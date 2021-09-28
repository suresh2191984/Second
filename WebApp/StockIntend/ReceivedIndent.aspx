<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceivedIndent.aspx.cs" Inherits="StockIntend_ReceivedIndent" meta:resourcekey="PageResource1" EnableEventValidation="false"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Indent Detail View</title>
    <%--<link href="../PlatForm/StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     
      <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/0001")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }  
       
    </script>
    <script type="text/javascript" language="javascript">

        function doPrint() {

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            //document.getElementById('tdBtns').style.display = "hide";
            $('#tdBtns').removeClass().addClass('hide');
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<style>.hide{display: none;}</style>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/Themes/IB/style.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(document.getElementById('divProjection').innerHTML);
            WinPrint.document.write('</body></html>');
            setTimeout(function() {
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
                //WinPrint.close();
            }, 1000);
            //document.getElementById('tdBtns').style.display = "show";
            $('#tdBtns').removeClass().addClass('displaytd a-center');

        }

        function Save() {
            //document.getElementById('btnSave').style.display = "hide";
            $('#btnSave').removeClass().addClass('hide');
            return true;
        }


        function SelectIntendRowCommon(rid, IntId, Intstatus) {
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('hdnId').value = IntId;
            document.getElementById('hdnStatus').value = Intstatus;
        }



        function ValidateQty(obj, s) {
            var textid1 = document.getElementById(obj).split('_');
            var New = document.getElementById(s).value;
            var textid1 = document.getElementById(id).innerHTML;
            if (document.getElementById('hdnQuantity').value == "") {
                document.getElementById('hdnQuantity').value = 0;
            }
            else {
                getElementById('hdnQuantity').value = document.getElementById(textid1[0] + '_' + textid1[1] + '_txtquantity').value;
            }
        }
        
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <div id="divProjection" runat="server">
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center">
                                        <%-- CssClass="hide"--%>
                                        <asp:Image ID="imgBillLogo" runat="server" meta:resourcekey="imgBillLogoResource1" />
                                        <br />
                                        <asp:Label CssClass="bold" ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                        <br />
                                        <asp:Label Font-Names="Verdana" ID="lblstreet" runat="server" meta:resourcekey="lblstreetResource1"></asp:Label>
                                        <br />
                                        <asp:Label Font-Names="Verdana" ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                        <br />
                                        <asp:Label Font-Names="Verdana" ID="lblPhonenumber" runat="server" meta:resourcekey="lblPhonenumberResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <%--<td class="a-center">
                                        
                                            <asp:Label ID="lblOrgName" CssClass="bold font16" runat="server" 
                                                meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                    </td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-15p">
                                                    <strong>
                                                        <asp:Label ID="lblDate1" runat="server" CssClass="bold" Text="Date :" 
                                                        meta:resourcekey="lblDate1Resource1"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td class="w-10">:</td>
                                                <td>
                                                    <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                                </td>
                                                <td class="w-15p">
                                                    <strong>
                                                        <asp:Label ID="lblIndent" CssClass="bold" runat="server" Text="Indent No :" 
                                                        meta:resourcekey="lblIndentResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td class="w-10">:</td>
                                                <td>
                                                    <asp:Label ID="lblIntendNo" runat="server" 
                                                        meta:resourcekey="lblIntendNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>
                                                        <asp:Label ID="lblIndentRaiseBy" CssClass="bold"  runat="server" Text="Indent Raised By:" 
                                                        meta:resourcekey="lblIndentRaiseByResource1"></asp:Label>
                                                </td>
                                                <td class="w-10">:</td>
                                                <td>
                                                    <asp:Label ID="lblRaiseBy" runat="server" 
                                                        meta:resourcekey="lblRaiseByResource1"></asp:Label></strong>
                                                </td>
                                                <td class="">
                                                   <strong>
                                                       <asp:Label ID="lblStat" CssClass="bold"  runat="server" Text="Status :" 
                                                        meta:resourcekey="lblStatResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td class="w-10">:</td>
                                                <td>
                                                    <asp:Label ID="lblStatus" runat="server" 
                                                        meta:resourcekey="lblStatusResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>
                                                        <asp:Label ID="lblIntRaiFrom" CssClass="bold"  runat="server" Text="Indent Raised From :" 
                                                        meta:resourcekey="lblIntRaiFromResource1"></asp:Label>
                                                        </strong>
                                                </td>
                                                <td class="w-10">:</td>
                                                <td>
                                                    <asp:Label ID="lblIndentRaiseTo" runat="server" 
                                                        meta:resourcekey="lblIndentRaiseToResource1"></asp:Label>
                                                </td>
                                                <td class="">
                                                  <strong> 
                                                      <asp:Label ID="lblIndentRece" CssClass="bold"  runat="server" Text="Indent ReceivedNo :" 
                                                        meta:resourcekey="lblIndentReceResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td class="w-10">:</td>
                                                <td>
                                                    <asp:Label ID="lblIndentReceivedNo" runat="server" 
                                                        meta:resourcekey="lblIndentReceivedNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>
                                                        <asp:Label ID="lblIndRaisedTo" CssClass="bold"  runat="server" Text="Indent Raised To :" 
                                                        meta:resourcekey="lblIndRaisedToResource1"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td class="w-10">:</td>
                                                <td>
                                                    <asp:Label ID="lblIndentFrom" runat="server" 
                                                        meta:resourcekey="lblIndentFromResource1"></asp:Label>
                                                </td>
                                                <td >
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="GridViewDetails" EmptyDataText="No matching records found " runat="server"
                                            Visible="False" AutoGenerateColumns="False" CssClass="gridView w-100p"
                                             meta:resourcekey="GridViewDetailsResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No." 
                                                    meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                        <asp:HiddenField ID="hdnCategoryId" runat="server" 
                                                            Value='<%# bind("CategoryId") %>' />
                                                        <asp:HiddenField ID="hdnTax" runat="server" Value='<%# bind("Tax") %>' />
                                                        <asp:HiddenField ID="hdnSellingUnit" runat="server" 
                                                            Value='<%# bind("SellingUnit") %>' />
                                                        <asp:HiddenField ID="hdnUnitPrice" runat="server" 
                                                            Value='<%# bind("UnitPrice") %>' />
                                                        <asp:HiddenField ID="hdnSellingPrice" runat="server" 
                                                            Value='<%# bind("SellingPrice") %>' />
                                                        <asp:HiddenField ID="hdnInvoiceQty" runat="server" 
                                                            Value='<%# bind("InvoiceQty") %>' />
                                                        <asp:HiddenField ID="hdnBatchNo" runat="server" 
                                                            Value='<%# bind("BatchNo") %>' />
                                                        <asp:HiddenField ID="hdnProductID" runat="server" 
                                                            Value='<%# bind("ProductID") %>' />
                                                        <asp:HiddenField ID="hdnpID" runat="server" Value='<%# bind("ID") %>' />
                                                        <asp:HiddenField ID="hdnpProductID" runat="server" 
                                                            Value='<%# bind("ProductID") %>' />
                                                        <asp:HiddenField ID="hdnpBatchNo" runat="server" 
                                                            Value='<%# bind("BatchNo") %>' />
                                                        <asp:HiddenField ID="hdnpQuantity" runat="server" 
                                                            Value='<%# bind("Quantity") %>' />
                                                        <asp:HiddenField ID="hdnpIssuQty" runat="server" 
                                                            Value='<%# bind("StockReceived") %>' />
                                                       
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ProductName" HeaderText="Product" 
                                                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                                        <asp:TemplateField HeaderText="Expiry Date" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "ExpiryDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Center" Width="10%" />
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                                                     
                                               </asp:TemplateField>
                                                <asp:BoundField DataField="BatchNo" HeaderText="Batch No" 
                                                    meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                                <asp:BoundField DataField="Quantity" HeaderText="Raised Quantity"  DataFormatString="{0:N}"
                                                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                                <asp:BoundField DataField="StockReceived" HeaderText="Issued Quantity"  DataFormatString="{0:N}"
                                                    meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                                            </Columns>
                                            <PagerStyle CssClass="gridPager" />
                                            <HeaderStyle CssClass="gridHeader" />
                                        </asp:GridView>
                                        
                                       <asp:GridView ID="gvIntendCancelDetail" EmptyDataText="No matching records found " runat="server"
                                            AutoGenerateColumns="False"
                                            CssClass="gridView w-100p" meta:resourcekey="gvIntendCancelDetailResource1">
                                            <Columns>
                                                <asp:BoundField DataField="ProductName" HeaderText="ProductName" 
                                                        meta:resourcekey="BoundFieldResource5"></asp:BoundField>                                              
                                               <asp:TemplateField HeaderText="RaisedQuantity" meta:resourcekey="BoundFieldResource12">
                                                 <ItemTemplate>
                                                  <%# (String.Format("{0}", Convert.ToInt32(Eval("Quantity")))) + " (" + Eval("SellingUnit") + ")"%>
                                                 </ItemTemplate>   
                                                 </asp:TemplateField>                                            
                                                <asp:BoundField DataField="Status" HeaderText="Status" 
                                                   meta:resourcekey="BoundFieldResource40"></asp:BoundField>
                                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                                                   meta:resourcekey="BoundFieldResource41"></asp:BoundField>
                                            </Columns>
                                       </asp:GridView>
                                        <br />                                       
                                        
                                        <asp:GridView ID="gvIntendDetail" EmptyDataText="No matching records found " runat="server"
                                            OnRowDataBound="gvIntendDetail_RowDataBound" AutoGenerateColumns="False"
                                            CssClass="gridView w-100p" 
                                            meta:resourcekey="gvIntendDetailResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SL No." 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                        <asp:HiddenField ID="hdnCategoryId" runat="server" 
                                                            Value='<%# bind("CategoryId") %>' />
                                                        <asp:HiddenField ID="hdnTax" runat="server" Value='<%# bind("Tax") %>' />
                                                        <asp:HiddenField ID="hdnSellingUnit" runat="server" 
                                                            Value='<%# bind("SellingUnit") %>' />
                                                        <asp:HiddenField ID="hdnUnitPrice" runat="server" 
                                                            Value='<%# bind("UnitPrice") %>' />
                                                        <asp:HiddenField ID="hdnSellingPrice" runat="server" 
                                                            Value='<%# bind("SellingPrice") %>' />
                                                        <asp:HiddenField ID="hdnInvoiceQty" runat="server" 
                                                            Value='<%# bind("InvoiceQty") %>' />
                                                        <asp:HiddenField ID="hdnBatchNo" runat="server" 
                                                            Value='<%# bind("BatchNo") %>' />
                                                        <asp:HiddenField ID="hdnProductID" runat="server" 
                                                            Value='<%# bind("ProductID") %>' />
                                                        <asp:HiddenField ID="hdnpID" runat="server" Value='<%# bind("ID") %>' />
                                                        <asp:HiddenField ID="hdnpProductID" runat="server" 
                                                            Value='<%# bind("ProductID") %>' />
                                                        <asp:HiddenField ID="hdnpBatchNo" runat="server" 
                                                            Value='<%# bind("BatchNo") %>' />
                                                        <asp:HiddenField ID="hdnpQuantity" runat="server" 
                                                            Value='<%# bind("Quantity") %>' />
                                                        <asp:HiddenField ID="hdnpIssuedQuantity" runat="server" 
                                                            Value='<%# bind("StockReceived") %>' />
                                                          <asp:HiddenField ID="hdnExpirydate" runat="server" 
                                                            Value='<%# bind("ExpiryDate") %>' />
                                                          <asp:HiddenField ID="hdnOrderedConvertUnit" runat="server"
                                                            Value='<%#bind("OrderedConvertUnit")%>' />
                                                         <asp:HiddenField ID="hdnPdtRcvdDtlsID" runat="server"
                                                            Value='<%#bind("ProductReceivedDetailsID")%>' />
                                                             <asp:HiddenField ID="hdnReceivedUniqueNumber" runat="server"
                                                            Value='<%#bind("ReceivedUniqueNumber")%>' />
                                                          
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ProductName" HeaderText="Product" 
                                                    meta:resourcekey="BoundFieldResource5"></asp:BoundField>
                                                        <asp:TemplateField HeaderText="Expiry Date" 
                                                    meta:resourcekey="TemplateFieldResource31">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "ExpiryDate", "{0:dd/MM/yyyy}").ToString())=="01/01/1753"? "-":
                                                                            GetDate(DataBinder.Eval(Container.DataItem, "ExpiryDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="gridHeader"/>
                                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                                                    
                                               </asp:TemplateField>
                                                <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" 
                                                    meta:resourcekey="BoundFieldResource6"></asp:BoundField>
                                                <asp:TemplateField HeaderText="RaisedQuantity"
                                                    meta:resourcekey="BoundFieldResource12">
                                                 <ItemTemplate>
                                                 <%# (String.Format("{0}", Convert.ToInt32(Eval("Quantity")))) + " (" + Eval("SellingUnit") + ")"%>
                                                 </ItemTemplate>   
                                                 </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Issued Quantity"
                                                    meta:resourcekey="BoundFieldResource8">
                                                    <ItemTemplate>
                                                    <%# (String.Format("{0}", Convert.ToInt32(Eval("StockReceived")))) + " (" + Eval("SellingUnit") + ")"%>
                                                 </ItemTemplate>
                                                 </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Received Quantity" ItemStyle-HorizontalAlign="Right" 
                                                    ItemStyle-Width="7%" meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtquantity" ReadOnly="true" runat="server" CssClass="paddingR10 w-60"
onkeydown="return validatenumber(event)"  Text='<%# (String.Format("{0}", Convert.ToInt32(Eval("StockReturn"))))%>' meta:resourcekey="txtquantityResource1"> </asp:TextBox>
                                                        <asp:HiddenField ID="hdnQuantity" runat="server" Value="0" />
                                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rack No" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="7%" meta:resourcekey="TemplateFieldRackResource1">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtrackno" runat="server" meta:resourcekey="txtracknoResource1" Text='<% #Eval("RakNo") %>'></asp:TextBox>
                                    </ItemTemplate>
<ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table runat="server" id="tdApproved" class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblApproved" runat="server" Text="Approved Date :" 
                                            meta:resourcekey="lblApprovedResource1"></asp:Label>
                                    </td>
                                    <td id="approvedDateTD" class="w-80p" runat="server">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                        <asp:Label ID="lblApprovedByss" runat="server" Text="Approved By " meta:resourcekey="lblApprovedByssResource1"></asp:Label>&nbsp;&nbsp;
                        :
                                    </td>
                                    <td id="approvedByTD" class="w-80p" runat="server">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table class="w-100p">
                            <tr>
                                <td class="a-center" id="tdBtns">
                                    <asp:Button ID="btnApprove" Visible="False" Text="Approve Indent" runat="server"
                                        onmouseover="this.className='btn btnhov'" CssClass="btn" onmouseout="this.className='btn'"
                                        CommandArgument="ApproveIntend" OnClick="btnIntend_Click" 
                                        meta:resourcekey="btnApproveResource1" />
                                    &nbsp;&nbsp;
                                    <asp:Button Visible="False" ID="btnCancelIntend" Text="Cancel Indent" runat="server"
                                        onmouseover="this.className='btn btnhov'" CssClass="btn" onmouseout="this.className='btn'"
                                        CommandArgument="CancelIntend" OnClick="btnIntend_Click" 
                                        meta:resourcekey="btnCancelIntendResource1" />
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnSave" Text="Save" Visible="False" runat="server" onmouseover="this.className='btn btnhov'"
                                        CssClass="btn" onmouseout="this.className='btn'" OnClientClick= "return Save()" OnClick="btnSave_Click" 
                                        meta:resourcekey="btnSaveResource1"  />
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnPrint" OnClientClick="doPrint();return false;" runat="server"
                                        onmouseout="this.className='btn'" 
                                        onmouseover="this.className='btn btnhov'" CssClass="btn"
                                        Text="Print" meta:resourcekey="btnPrintResource1" />
                                   <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" 
                                        CssClass="cancel-btn" Text="Back" meta:resourcekey="btnBackResource1" />
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnIndentID" runat="server"  />
                         <asp:HiddenField ID="hdnIntendReceivedID" runat="server"  />
                    </div>
                
      <asp:HiddenField ID ="hdnMessages" runat ="server" />
      <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <script language="javascript" type="text/javascript">
        var ErrorMsg = SListForAppMsg.Get("StockIntend_Error") == null ? "Error" : SListForAppMsg.Get("StockIntend_Error");
        var infromMsg = SListForAppMsg.Get("StockIntend_Information") == null ? "Information" : SListForAppMsg.Get("StockIntend_Information");
        var OkMsg = SListForAppMsg.Get("StockIntend_Ok") == null ? "Ok" : SListForAppMsg.Get("StockIntend_Ok");
        var CancelMsg = SListForAppMsg.Get("StockIntend_Cancel") == null ? "Cancel" : SListForAppMsg.Get("StockIntend_Cancel");
    </script>
    <script language="javascript" type="text/javascript">
        function ValidateReturnQty(IssuedQuantity, ReturnQuantity) {
            
//            var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
//            var pReturnQuantity = document.getElementById(ReturnQuantity).value;


            var pIssuedQuantity = ToInternalFormat($('#'+IssuedQuantity));
            var pReturnQuantity = ToInternalFormat($('#'+ReturnQuantity));
            
            if (Number(pIssuedQuantity) < Number(pReturnQuantity)) {
                var userMsg = SListForAppMsg.Get("StockIntend_ReceivedIndent_aspx_01") == null ? "Provide  less than or equal to issued quantity" : SListForAppMsg.Get("StockIntend_ReceivedIndent_aspx_01");
                ValidationWindow(userMsg,ErrorMsg);         
                    document.getElementById(ReturnQuantity).value = 0;
                          
                document.getElementById(ReturnQuantity).value = '';
                document.getElementById(ReturnQuantity).focus();
                return false;
            }

        }
    </script>

</body>
</html>
