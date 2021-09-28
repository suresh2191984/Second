<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductLegend.aspx.cs" Inherits="InventoryReports_ProductLegend"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Product Legend</title>

  

    <script src="Scripts/GridviewSelRow.js" type="text/javascript"></script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <table class="w-100p lh30">
                        <tr class="panelContent">
                            <td>
                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                    CssClass="small" meta:resourcekey="ddlTrustedOrgResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="fromDate" Text="From" meta:resourcekey="fromDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                    CssClass="xsmaller datePickerPres" meta:resourcekey="txtFromResource1" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="toDate" Text="To" meta:resourcekey="toDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTo" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"
                                    CssClass="xsmaller datePickerPres" meta:resourcekey="txtToResource1" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblProduct" Text="Product Name" meta:resourcekey="lblProductResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProduct" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                    CssClass="small" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                    OnClientItemSelected="ProductItemSelected" ServiceMethod="GetSearchProductList"
                                    ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                    MinimumPrefixLength="2" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                    DelimiterCharacters=";,:" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClick="btnSearch_Click" OnClientClick="javascript:return CheckDates('')" meta:resourcekey="btnSearchResource1" />
                                <asp:LinkButton ID="lnkBack" Text="Back" runat="server" CssClass="cancel-btn" OnClick="lnkBack_Click"
                                    meta:resourcekey="lnkBackResource1">
                                    <asp:Label ID="lblBack" Text="Back" runat="server" meta:resourcekey="lblBackResource1"></asp:Label>
                                </asp:LinkButton>
                            </td>
                <td>
                    <div id="contentArea" runat="server" class="hide">
                        <table>
                            <tr>
                                <td class="a-right">
                                    <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                </td>
                                <td class="a-right">
                                    <asp:ImageButton ID="btnprnt" runat="server" ImageUrl="~/PlatForm/Images/printer.gif" OnClientClick="return popupprint();"
                                        ToolTip="Print" meta:resourcekey="btnprntResource1" />
                                                <%--<b id="printText" runat="server">
                                        <asp:LinkButton ID="lnkPrint" Text="Print Report" OnClientClick="return popupprint();"
                                                        runat="server" meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divPrintareaProductReport" class="w-100p">
                        <input type="hidden" id="hdnRowCount" runat="server" />
                        <asp:GridView OnRowCreated="gridView_RowCreated" ID="grdResult" AllowPaging="True"
                            runat="server" AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound"
                            OnPageIndexChanging="grdResult_PageIndexChanging" CssClass="gridView w-100p"
                            ShowFooter="True" meta:resourcekey="grdResultResource1">
                            <PagerStyle CssClass="gridPager a-center" />
                            <HeaderStyle CssClass="gridHeader" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hypProduct" Text='<%# Eval("ProductName") %>' Target="_blank"
                                            runat="server"></asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="OpeningBalance" DataFormatString="{0:N}" HeaderText="Opening Balance"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource1">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="OpeningStockValueCP" DataFormatString="{0:N}" HeaderText="Opening Stock Value@CP"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource2">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="OpeningStockValue" DataFormatString="{0:N}" HeaderText="Opening Stock Value@SP"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource3">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ClosingBalance" DataFormatString="{0:N}" HeaderText="Closing Balance"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource4">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ClosingStockValueCP" DataFormatString="{0:N}" HeaderText="Closing Stock Value@CP"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource5">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ClosingStockValue" DataFormatString="{0:N}" HeaderText="Closing Stock Value@SP"
                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource6">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <div class="searchPanel a-right marginT30">
                            <div id="total" runat="server">
                                <strong>
                                    <asp:Label ID="labeltotal" runat="server" Text="Total Stock Value@SP :" meta:resourcekey="labeltotalResource1"></asp:Label></strong>
                                <asp:Label ID="lblTotalStockValue" Text="0" runat="server" meta:resourcekey="lblTotalStockValueResource1"></asp:Label>
                                <br />
                                <strong>
                                    <asp:Label ID="labelstock" runat="server" Text="Total Stock Value@CP :" meta:resourcekey="labelstockResource1"></asp:Label></strong>
                                <asp:Label ID="lblTotalStockValueCP" Text="0" runat="server" meta:resourcekey="lblTotalStockValueCPResource1"></asp:Label>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr class="panelContent" id="trError" runat="server">
                <td class="a-center">
                    <table class="w-100p">
                        <tr>
                            <td>
                                <div class="ui-state-info ui-corner-all">
                                    <p>
                                        <span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-info"></span>
                                        <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label></p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnProductCategories" runat="server" />
    <input type="hidden" id="hdnProductCategorieschk" runat="server" />
    <input type="hidden" id="hdnIsflag" runat="server" />
      <script language="javascript" type="text/javascript">
          var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Alert" : SListForAppMsg.Get("InventoryReports_Error");
          var InformationMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information");
          var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok");
          var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel");

          function ProductItemsSelected(source, eventArgs) {
              //debugger;
              var Product = eventArgs.get_text().split('^^');
              document.getElementById('txtProduct').value = Product[0];

          }
          function CheckDates(splitChar) {
              if (document.getElementById('txtFrom').value == '') {
                  var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_01") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_01");
                  ValidationWindow(userMsg, errorMsg);
                  return false;
              }
              else if (document.getElementById('txtTo').value == '') {
                  var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_02") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_02");
                  ValidationWindow(userMsg, errorMsg);
                  return false;
              }
              else {
                  //Assign From And To Date from Controls 
                  DateFrom = document.getElementById('txtFrom').value;
                  DateTo = document.getElementById('txtTo').value;
                 // DateNow = now.split(splitChar);
                  //Argument Value 0 for validating Current Date And To Date 
                  //Argument Value 1 for validating Current From And To Date 
                  //if (doDateValidation(DateTo, DateNow, 0)) {
                  if (CheckFromToDate(DateFrom, DateTo)) {
                          //alert("Validation Succeeded");

                          return true;
                      }
                      else {
                          return false;
                      }
                 // }
                 // else {
                //      return false;
                 // }
              }
          }
          function doDateValidation(from, to, bit) {
              var dayFlag = true;
              var monthFlag = true;
              var i = from.length - 1;
              if (Number(to[i]) >= Number(from[i])) {
                  if (Number(to[i]) == Number(from[i])) {
                      monthFlag = false;
                  }
                  i--;
                  if (Number(to[i]) >= Number(from[i])) {
                      if (Number(to[i]) == Number(from[i])) {
                          dayFlag = false;
                      }
                      i--;
                      if (Number(to[i]) >= Number(from[i])) {
                          i--;
                          return true;
                      }
                      else {
                          if (dayFlag) {
                              return true;
                          }
                          else {
                              if (bit == 0) {
                                  var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_03") == null ? "Mismatch Day Between Current & To Date" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_03");
                                  ValidationWindow(userMsg, errorMsg);
                                  return false;
                              }
                              else {
                                  var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_04") == null ? "Mismatch Day Between From & To Date" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_04");
                                  ValidationWindow(userMsg, errorMsg);
                                  return false;
                              }
                              return false;
                          }
                      }
                  }
                  else if (monthFlag) {
                      return true;
                  }
                  else {
                      if (bit == 0) {
                          var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_05") == null ? "Mismatch Month Between Current & To Date" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_05");
                          ValidationWindow(userMsg, errorMsg);
                          return false;
                      }
                      else {
                          var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_06") == null ? "Mismatch Month Between From & To Date" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_06");
                          ValidationWindow(userMsg, errorMsg);
                          return false;
                      }
                      return false;
                  }
              }
              else {
                  if (bit == 0) {
                      var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_07") == null ? "Mismatch Year Between Current & To Date" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_07");
                      ValidationWindow(userMsg, errorMsg);
                      return false;
                  }
                  else {
                      var userMsg = SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_08") == null ? "Mismatch Year Between From & To Date" : SListForAppMsg.Get("InventoryReports_ProductLegend_aspx_08");
                      ValidationWindow(userMsg, errorMsg);
                      return false;
                  }
                  return false;
              }
          }


          function popupprint() {
              var prtContent = document.getElementById('divPrintareaProductReport');

              var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
              //alert(WinPrint);
              WinPrint.document.write($('head').html() + prtContent.innerHTML);
              WinPrint.document.close();
              WinPrint.focus();
              WinPrint.print();
              WinPrint.close();
          }
          function clearContextText() {
              $('#contentArea').hide();
          }
		  $(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>
    </form>
</body>
</html>
