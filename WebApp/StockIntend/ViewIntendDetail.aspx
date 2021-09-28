<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewIntendDetail.aspx.cs"
    Inherits="Inventory_ViewIntendDetail" meta:resourcekey="PageResource1" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Indent Detail View</title>
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
                    <td class="a-center bold" colspan="4">
                        <asp:Image ID="imgBillLogo" runat="server" class="hide a-center" meta:resourcekey="imgBillLogoResource1" />
                        <br />
                        <asp:Label CssClass="bold" Font-Names="Verdana" ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblstreet" runat="server" meta:resourcekey="lblstreetResource1"></asp:Label>
                        <br />
                        <asp:Label Font-Names="Verdana" ID="lblPhonenumber" runat="server" meta:resourcekey="lblPhonenumberResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="w-100p searchPanel paddingT10">
                            <tr>
                                <td class="w-76p">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="w-25p">
                                                <asp:Label ID="lblDate1" runat="server" class="bold" Text="Date  " meta:resourcekey="lblDate1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblIndentRaiseBy" runat="server" class="bold" Text="Indent Raised By  "
                                                    meta:resourcekey="lblIndentRaiseByResource1"></asp:Label>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRaiseBy" runat="server" meta:resourcekey="lblRaiseByResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" class="bold" Text="Indent Raised From " meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblIndentRaiseTo" runat="server" meta:resourcekey="lblIndentRaiseToResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblIndentRaisedTo" runat="server" class="bold" Text="Indent Raised To "
                                                    meta:resourcekey="lblIndentRaisedToResource1"></asp:Label>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblIndentFrom" runat="server" meta:resourcekey="lblIndentFromResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="a-right v-top">
                                    <table class="a-right">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblIndentNo1" runat="server" class="bold" Text="Indent No " meta:resourcekey="lblIndentNo1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblIntendNo" runat="server" meta:resourcekey="lblIntendNoResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblStatus1" runat="server" class="bold" Text="Status" meta:resourcekey="lblStatus1Resource1"></asp:Label>
                                            </td>
                                            <td>
                                                :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="GridViewDetails" EmptyDataText="No matching records found " runat="server"
                            AutoGenerateColumns="False" CssClass="gridView w-100p" OnRowDataBound="GridViewDetails_RowDataBound"
                            meta:resourcekey="GridViewDetailsResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField ID="hdnCategoryId" runat="server" Value='<%# bind("CategoryId") %>' />
                                        <asp:HiddenField ID="hdnTax" runat="server" Value='<%# bind("Tax") %>' />
                                        <asp:HiddenField ID="hdnSellingUnit" runat="server" Value='<%# bind("SellingUnit") %>' />
                                        <asp:HiddenField ID="hdnUnitPrice" runat="server" Value='<%# bind("UnitPrice") %>' />
                                        <asp:HiddenField ID="hdnSellingPrice" runat="server" Value='<%# bind("SellingPrice") %>' />
                                        <asp:HiddenField ID="hdnInvoiceQty" runat="server" Value='<%# bind("InvoiceQty") %>' />
                                        <asp:HiddenField ID="hdnBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpID" runat="server" Value='<%# bind("ID") %>' />
                                        <asp:HiddenField ID="hdnpProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnpQuantity" runat="server" Value='<%# bind("Quantity") %>' />
                                        <asp:HiddenField ID="hdnConvertQuantity" runat="server" Value='<%# bind("OrderedConvertUnit") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" HeaderText="Product" ItemStyle-HorizontalAlign="left"
                                    meta:resourcekey="BoundFieldResource1">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ProductCode" HeaderText="Product Code" ItemStyle-HorizontalAlign="left" /> 
                                <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" meta:resourcekey="BoundFieldResource2">
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="RaisedQuantity" ItemStyle-HorizontalAlign="Right"
                                    ItemStyle-Width="7%" Visible="False" meta:resourcekey="TemplateRaisedQty">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRaisedquantity" runat="server" CssClass="hide"
                                            onkeypress="return ValidateSpecialAndNumeric(this);" Text='<%# bind("Quantity","{0:N}") %>'
                                            meta:resourcekey="txtRaisedquantityResource1"></asp:TextBox>
                                        <asp:Label ID="lblRaisedquantity" runat="server" Text='<%# bind("Quantity","{0:N}") %>'
                                            meta:resourcekey="lblRaisedquantityResource1"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:BoundField DataField="StockReceived" HeaderText="Issued Quantity" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource4">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="RECQuantity" HeaderText="Received Quantity" DataFormatString="{0:N}"
                                    meta:resourcekey="BoundFieldResource5"></asp:BoundField>
                                <asp:BoundField DataField="SellingUnit" HeaderText="SellingUnit" ItemStyle-HorizontalAlign="left"
                                    meta:resourcekey="BoundFieldResource6">
                                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="FromInHandQuantity" ItemStyle-HorizontalAlign="left" meta:resourcekey="BoundFieldResource3">
                                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ToInHandQuantity" HeaderText="InHandQuantity" ItemStyle-HorizontalAlign="Right"
                                    meta:resourcekey="BoundFieldResource7">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="OrderedUnit" HeaderText="Ordered Unit" ItemStyle-HorizontalAlign="Right"
                                    meta:resourcekey="BoundFieldOrderedUnit">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="OrderedConvertUnit" HeaderText="Pack Size" ItemStyle-HorizontalAlign="Right"
                                    meta:resourcekey="BoundFieldOrderedConvertUnit">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="OrderedConvertUnit" HeaderText="Pack Size" ItemStyle-HorizontalAlign="Right"
                                    meta:resourcekey="BoundFieldOrderedQuantity">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                        <asp:GridView ID="gvIntendDetail" EmptyDataText="No matching records found " runat="server"
                            OnRowDataBound="gvIntendDetail_RowDataBound"
                            AutoGenerateColumns="False" CssClass="gridView w-100p" meta:resourcekey="gvIntendDetailResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:HiddenField ID="hdnCategoryId" runat="server" Value='<%# bind("CategoryId") %>' />
                                        <asp:HiddenField ID="hdnTax" runat="server" Value='<%# bind("Tax") %>' />
                                        <asp:HiddenField ID="hdnSellingUnit" runat="server" Value='<%# bind("SellingUnit") %>' />
                                        <asp:HiddenField ID="hdnUnitPrice" runat="server" Value='<%# bind("UnitPrice") %>' />
                                        <asp:HiddenField ID="hdnSellingPrice" runat="server" Value='<%# bind("SellingPrice") %>' />
                                        <asp:HiddenField ID="hdnInvoiceQty" runat="server" Value='<%# bind("InvoiceQty") %>' />
                                        <asp:HiddenField ID="hdnBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpID" runat="server" Value='<%# bind("ID") %>' />
                                        <asp:HiddenField ID="hdnpProductID" runat="server" Value='<%# bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnpBatchNo" runat="server" Value='<%# bind("BatchNo") %>' />
                                        <asp:HiddenField ID="hdnpQuantity" runat="server" Value='<%# bind("Quantity") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" HeaderText="Product" meta:resourcekey="BoundFieldResource7">
                                </asp:BoundField>
                                <asp:BoundField DataField="BatchNo" HeaderText="Batch No" meta:resourcekey="BoundFieldResource8">
                                </asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="Intend Raised Quantity" meta:resourcekey="BoundFieldResource9"
                                    DataFormatString="{0:N}"></asp:BoundField>
                                <asp:TemplateField HeaderText="RecQuantity" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="7%"
                                    meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtquantity" runat="server" Style="padding-right: 10px;" Width="60px"
                                            onkeypress="return ValidateSpecialAndNumeric(this)&& CheckRow(this.id);" meta:resourcekey="txtquantityResource1"></asp:TextBox>
                                        <asp:HiddenField ID="hdnQuantity" runat="server" Value="0" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Width="7%"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="gridPager" />
                            <HeaderStyle CssClass="gridHeader" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br />
            <table class="a-center w-80p" runat="server" id="tdApproved" style="display:none;">
                <tr class="bold">
                    <td>
                        <asp:Label ID="lblApprovedDate" runat="server" Text="Approved Date" meta:resourcekey="lblApprovedDateResource1"></asp:Label>
                    </td>
                    <td id="approvedDateTD" class="w-80p a-left" runat="server">
                    </td>
                </tr>
                <tr class="bold">
                    <td>
                        <asp:Label ID="lblApprovedBy" runat="server" Text="Approved By" meta:resourcekey="lblApprovedByResource1"></asp:Label>
                        &nbsp;&nbsp; :
                    </td>
                    <td id="approvedByTD" class="bold a-left" runat="server">
                    </td>
                </tr>
            </table>
        </div>
        <table class="w-95p">
            <tr>
                <td class="a-center" id="tdBtns">
                    <asp:Button ID="btnApprove"  Visible="False" Text=" Approve Indent " runat="server" OnClientClick="return chkRejecttext(this)"
                         CssClass="btn" CommandArgument="ApproveIntend" OnClick="btnIntend_Click" meta:resourcekey="btnApproveResource1" />
                    &nbsp;&nbsp;
                     <asp:Button Visible="False"  ID="btnReject" Text=" Reject Indent " runat="server" OnClientClick="return chkRejecttext(this)"
                         CssClass="btn" CommandArgument="RejectIntend" meta:resourcekey="btnRejectIntendResource1" />
                    &nbsp;&nbsp;
                    <asp:Button Visible="False" ID="btnCancelIntend" Text=" Cancel Indent " runat="server"
                        CssClass="cancel-btn" CommandArgument="CancelIntend" OnClick="btnCancelIntend_Click"
                        meta:resourcekey="btnCancelIntendResource1" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnPrint" runat="server" OnClientClick="doPrint();return false;"
                        CssClass="btn" Text=" Print " meta:resourcekey="btnPrintResource1" />
                    <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" CssClass="cancel-btn"
                        Text="Back" meta:resourcekey="btnBackResource1" />
                           <asp:Button  ID="btnRejectdummyconfirm" Text="Reject Indent " runat="server"  
                                CssClass="hide" CommandArgument="RejectIntend" OnClick="btnRejectdummyconfirm_Click"  />
                </td>
            </tr>
        </table>
    </div>
    
    <div class="modal fade w-30p hide" id="divReject" role="dialog" data-role="popup">
    <div class="modal-dialog w-auto">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #DCDCDC; padding: 0px;">
                <h4 class="modal-title">
                    </h4>
                <h4 class="modal-title">
                    </h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div>
                        <div class="form-group">
                            <label class="control-label bold">
                              Reject Reason
                            </label>
                            <div class="marginT10 marginB10"> 
                               
                                <asp:TextBox ID="txtRejectComments" CssClass="medium"  maxlength="255" TextMode="MultiLine" runat="server"
                                    Columns="25" Rows="2" meta:resourcekey="txtRejectComments1"></asp:TextBox>
                            </div>
                            <div class="a-center">
                               <asp:Button ID="btnRejectConfirm" Text=" Reject Indent " runat="server" OnClientClick="chkvalRejecttext(this)"
                                CssClass="btn" CommandArgument="RejectIntend"   />
                                &nbsp;&nbsp;
                                <input id="btnCancel" onclick="return ClosemodelPopup(this);" value="Cancel" type="button" class="btn" 
                                    />
                                    
                             
                                &nbsp;&nbsp;
                             
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input type="hidden" id="hdnEnablePackSize" runat="server" />
     <input type="hidden" id="hdnRejectStatus" value="N" runat="server" />
      <input type="hidden" id="hdnRejectReasonvalues" value="" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        //-------------Mani--------
        $(document).ready(function() {
            if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'ViewIntendDetail') {
                $("#Attuneheader_TopHeader1_lblvalue").text("View Indent Detail");
            }
        $('#btnRejectdummyconfirm').hide();
        });
        //----------End------------
        var errorMsg = SListForAppMsg.Get('StockIntend_Error') == null ? "Alert" : SListForAppMsg.Get('StockIntend_Error');
        var informMsg = SListForAppMsg.Get('StockIntend_Information') == null ? "Information" : SListForAppMsg.Get('StockIntend_Information');
        var okMsg = SListForAppMsg.Get('StockIntend_Ok') == null ? "Ok" : SListForAppMsg.Get('StockIntend_Ok')
        var cancelMsg = SListForAppMsg.Get('StockIntend_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockIntend_Cancel');
        function ValidateReturnQty(IssuedQuantity, ReturnQuantity) {


            ////        var pIssuedQuantity = document.getElementById(IssuedQuantity).value;
            ////        var pReturnQuantity = document.getElementById(ReturnQuantity).value;

            var pIssuedQuantity = ToInternalFormat($('#' + IssuedQuantity));
            var pReturnQuantity = ToInternalFormat($('#' + ReturnQuantity));

            if (Number(pIssuedQuantity) < Number(pReturnQuantity)) {
                var userMsg = SListForAppMsg.Get("StockIntend_ViewIntendDetail_aspx_01") == null ? "Provide return quantity less than or equal to issued quantity" : SListForAppMsg.Get("StockIntend_ViewIntendDetail_aspx_01")
                ValidationWindow(userMsg, errorMsg);

                return false;


                //document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                document.getElementById(ReturnQuantity).value = '';
                document.getElementById(ReturnQuantity).focus();
                return false;
            }

        }
    </script>

    <script type="text/javascript" language="javascript">
    
        var userMsg;
        function doPrint() {
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            $('#tdBtns').removeClass().addClass('hide');
            $('#<%=GridViewDetails.ClientID %>').find('span[id$="lblRaisedquantity"]').show();
            $('#<%=GridViewDetails.ClientID %>').find('input:text[id$="txtRaisedquantity"]').hide();
            var prtContent = document.getElementById('divProjection');
            WinPrint.document.write('<html><head><title></title>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            WinPrint.document.close();
            WinPrint.focus();
            setTimeout(function() {
                WinPrint.print();
                WinPrint.close();
            }, 1000);
            $('#tdBtns').removeClass().addClass('displaytd a-center w-100p');
			chkRejecttext(obj);

        }

        function CheckRow(id) {

            var textid = (document.getElementById(id).id).split('_');


            // var txtQty= document.getElementById('hdnpQuantity').value;

            //  document.getElementById(textid[0] + '_' + textid[1] + '_chkProduct').checked = true;


        }

        function Getqty() {
    }
    function chkvalRejecttext(obj) {
        if ($('#txtRejectComments').val() == '') {
            alert('Please enter the reject reason');
            return false;
        }
        else {
            $("#hdnRejectReasonvalues").val($('#txtRejectComments').val());
            $("#btnRejectdummyconfirm").click();
            return true;
        }
    }

    function ClosemodelPopup(obj) {
        $("#divReject").dialog('close');
        return false;
    }

    function chkRejecttext(obj) {
        if (obj.id == "btnReject") {
            $("#divReject").removeClass.addClass('modal fade w-30p show');
         
            $("#divReject").dialog(
          {
              modal: true,
              height: 250,
              autoOpen: false,
              width: 70,    
              title: 'Intend Reject Reason',
              dialogClass: 'closeTitleBar',
              open: function(event, ui) {
                  $(this).parent().addClass("w-auto");
                  $(this).parent().css("left", "40%");
              }
          });
          $("#divReject").dialog('open');
            return false;
        }
        else {
          
        }
        }

        //        function ValidateQty(obj,s) {
        //            alert(s);
        //            var textid1 = document.getElementById(obj).split('_');
        //            //var Qty = document.getElementById(textid1[0] + '_' + textid1[1] + '_hdnpQuantity').value;
        //            var New = document.getElementById(s).value;
        //            alert(Qty);
        //            var New = document.getElementById(s).value;
        //           // var textid = document.getElementById(obj).split('_');
        //            alert(New);

        //            //document.getElementById(textid[0] + '_' + textid[1] + '_chkProduct')
        ////            var textid1 = document.getElementById(id).innerHTML;
        //           
        ////            if (document.getElementById('hdnQuantity').value == "") {
        ////            document.getElementById('hdnQuantity').value =0;
        ////            }
        ////            else{

        ////            getElementById('hdnQuantity').value = document.getElementById(textid1[0] + '_' + textid1[1] + '_txtquantity').value;
        ////            var qty = document.getElementById('hdnQuantity').value;
        ////            alert(qty);
        ////            
        //        }
        
    </script>

</body>
</html>
