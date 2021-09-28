<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockDetails.aspx.cs" Inherits="StockManagement_StockDetails"
    meta:resourcekey="PageResource1"  EnableEventValidation="false"%>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Details</title>
</head>
<body oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
<%--        <ul>
            <li>
                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
            </li>
        </ul>--%>
        <table class="w-100p">
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="upnelInv" runat="server">
                     <Triggers>
            
                <asp:PostBackTrigger ControlID="imgBtnXL" />
           <asp:PostBackTrigger ControlID="btnprnt" />
            </Triggers>
                        <ContentTemplate>
                            <table class="w-100p v-top searchPanel">
                                <tr class="panelHeader">
                                    <td class="a-left">
                                        <div runat="server" id="ACX2OPPmt">
                                            <img src="../PlatForm/Images/ShowBids.gif" alt="Show" class="a-top pointer"
                                                onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                            <span class="pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                <asp:Label ID="Rs_ProductSearch" Text="Product Search" runat="server" meta:resourcekey="Rs_ProductSearchResource1"></asp:Label></span>
                                        </div>
                                        <div runat="server" id="ACX2minusOPPmt" class="hide">
                                            <img src="../PlatForm/Images/HideBids.gif" alt="hide" class="a-top pointer"
                                                onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                            <span class="pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                <asp:Label ID="Rs_ProductSearch1" Text="Product Search" runat="server" meta:resourcekey="Rs_ProductSearch1Resource1"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="panelContent hide" runat="server" id="ACX2responsesOPPmt">
                                    <td runat="server">
                                        <uc1:ProductSearch ID="ProductSearch1" runat="server" />
                                    </td>
                                     
                                   <td class="a-left">
                                  <td align="right">
										<asp:ImageButton ID="imgBtnXL" OnClick="btnExcel_Click" runat="server" ImageUrl="../PlatForm/images/ExcelImage.GIF"
											ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource2" />
									</td>
                                    
                                    </td>
                                    <td >
                                         <asp:ImageButton ID="btnprnt" runat="server" CssClass="marginL10" ImageUrl="~/PlatForm/Images/printer.gif"
                                                  OnClick="btnprnt_Click"   ToolTip="Print"  meta:resourcekey="btnprntResource1" />
                                               
                                    </td>
                                </tr>
                            </table>
                              <div id="dPrint" runat="server"   >  
                         
                            
                                          
                            <asp:GridView ID="grdResult" EmptyDataText="No matching records found " runat="server" 
                                AutoGenerateColumns="false" CssClass="gridView w-100p" OnPageIndexChanging="grdResult_PageIndexChanging"
                                PageSize="15" AllowPaging="True" meta:resourcekey="grdResultResource1" OnRowDataBound="grdResult_RowDataBound">
                                  <HeaderStyle CssClass="gridHeader" />
                                <Columns>
                                    <asp:BoundField HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" meta:resourcekey="BoundFieldResource2" />
                                    <asp:BoundField HeaderText="Expiry Date" DataFormatString="{0:MMM-yyyy}" DataField="ExpiryDate"
                                        meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField HeaderText="InHand Qty" DataField="InHandQuantity" meta:resourcekey="BoundFieldResource4" />
                                    <asp:BoundField HeaderText="Unit" DataField="RECUnit" meta:resourcekey="BoundFieldResource5" />
                                    <asp:BoundField HeaderText="Selling Price" DataField="Rate" meta:resourcekey="BoundFieldResource6" ItemStyle-HorizontalAlign="Right" />
                                    <asp:BoundField HeaderText="Tax%" DataField="Tax" meta:resourcekey="BoundFieldResource7" />
                                    <asp:BoundField HeaderText="Rak No" DataField="RakNo" meta:resourcekey="BoundFieldResource8" />
                                </Columns>
                                <PagerStyle CssClass="gridPager a-center" />
                                <HeaderStyle CssClass="gridHeader a-center" />
                            </asp:GridView>
                        
                             </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
     <asp:HiddenField ID="hdnPageName" runat="server" />
    </form>
</body>
</html>

    <script type="text/javascript">
    $(window).bind('beforeunload', function() {
        $('#preloader').hide();
    });
</script>