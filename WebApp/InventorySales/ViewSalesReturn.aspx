<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewSalesReturn.aspx.cs"
    Inherits="InventorySales_ViewSalesReturn" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Sales Return</title>

    <script src="../PlatForm/Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function CallPrint() {
            var prtContent = document.getElementById('DivReturn');

            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
      <div class="contentdata">
                    
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                      <ContentTemplate>
                       
                        <div id="DivReturn" >
                        <table class="w-100p" ><tr><td>
                            <table class="w-80p a-center custfontwidth2 cust1backgrnd10 border1 custcellspacing1 borderstyle3 custcellpadding5" >
                                <tr>
                                    <td colspan="3" class="a-center h-25 bold font12">                                      
                                            <asp:Label ID="lblStkRtn" runat="server" Text="Stock Return" meta:resourcekey="lblStkRtnResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="a-center h-25 bold font12">
                                        <asp:Label ID="lblOrgName" runat="server"  meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                 <tr>
                                    <td colspan="3" class="font12 bold h-25" >
                                        <asp:Label ID="lblfrom" runat="server" Text="From" meta:resourcekey="lblfromResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="h-15">
                                 
                                    <td class="a-left" >
                                        <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                    </td>
                                   
                                    <td    class="a-right" >
                                          <asp:Label ID="lbldate" runat="server" Text="Date :" meta:resourcekey="lbldateResource1"></asp:Label>
                                    </td>
                                    <td class="a-left bold" >
                                        &nbsp;<asp:Label ID="lblSRDate" runat="server" meta:resourcekey="lblSRDateResource1"></asp:Label></td>
                                </tr>
                                <tr class="h-15">
                               
                                    <td >
                                        <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                    </td>
                                    <td class="a-right" >
                                       <asp:Label ID="lblreturnno" Text="StockReturn No:" runat="server" meta:resourcekey="lblreturnnoResource1"></asp:Label>
                                    </td>
                                    <td class="a-left bold">
                                        &nbsp;
                                        <asp:Label ID="lblSRID" runat="server" meta:resourcekey="lblSRIDResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="h-15">
                                <td>
                                    <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                                    </td>
                                    <td class="a-right" >
                                        <asp:Label ID="lblstatusd" Text="Status :" runat="server" meta:resourcekey="lblstatusdResource1"></asp:Label></td>
                                    <td class="a-left bold" >
                                        
                                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                    </td>
                                    <td class="a-left bold">
                                        &nbsp;
                                        </td>
                                </tr>
                               
                                <tr>
                                    <td  colspan="3" >
                                    <asp:Label ID="lblTo" Text ="To," runat ="server" eta:resourcekey="lblToResource1" 
                                            meta:resourcekey="lblToResource1" ></asp:Label>
                                      
                                    </td>
                                    
                                   
                                </tr>
                                <tr class="a-left bold">
                                    <td colspan="3">
                                        <asp:Label ID="lblVendorName" runat="server" meta:resourcekey="lblVendorNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="h-15">
                                    <td colspan="3">
                                        <asp:Label ID="lblVendorAddress" runat="server" meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="h-15">
                                    <td colspan="3">
                                        <asp:Label ID="lblVendorCity" runat="server" 
                                            meta:resourcekey="lblVendorCityResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr class="h-15">
                                    <td colspan="3">
                                        <asp:Label ID="lblVendorPhone" runat="server" 
                                            meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                    </td>
                                </tr>
                                 
                                <tr>
                                    <td colspan="3" class="hide" >
                                        <asp:GridView ID="grdResult" EmptyDataText="No matching records found " runat="server"
                                                    AutoGenerateColumns="False" class="w-100p custcellspacing2 custcellpadding3" OnRowDataBound="grdResult_RowDataBound"
                                                    DataKeyNames="ProductKey" 
                                            meta:resourcekey="grdResultResource1">
                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <Columns>
                                                    
                                                 
                                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                                                     
                                                        <asp:HiddenField ID="hdnBatchNo" runat="server" 
                                                            Value='<%# bind("BatchNo") %>' />
                                                        <asp:HiddenField ID="hdnProductID" runat="server" 
                                                            Value='<%# bind("ProductID") %>' />
                                                        <asp:HiddenField ID="hdnpProductKey" runat="server" 
                                                            Value='<%# bind("ProductKey") %>' />
                                                        <asp:HiddenField ID="hdnpInHandQuantity" runat="server" 
                                                            Value='<%# bind("InHandQuantity") %>' />
                                                        <asp:HiddenField ID="hdnpUnits" runat="server" Value='<%# bind("Unit") %>' />
                                                       
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="true" ItemStyle-Width="20%"
                                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderText="SRD No"
                                                            DataField="Description" meta:resourcekey="BoundFieldResource1" >
<HeaderStyle HorizontalAlign="Left" Wrap="False"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" Wrap="True"  CssClass="w-15p"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="true" ItemStyle-Width="20%"
                                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderText="Product Name"
                                                            DataField="ProductName" meta:resourcekey="BoundFieldResource2">
<HeaderStyle HorizontalAlign="Left" Wrap="False"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" Wrap="True"  CssClass="w-20p"></ItemStyle>
                                                        </asp:BoundField>
                                                            <asp:BoundField HeaderText="Batch No" DataField="BatchNo" Visible="True"  meta:resourcekey="BoundFieldResource3"/>
                                                        <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" Text='<%# Eval("Quantity") %>'  CssClass="w-60" ID="txtQuantity" 
                                                                    runat="server" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Inhand Qty"  meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label Text='<%# Eval("InHandQuantity") %>' CssClass="w-40" ID="lblInHandQty" 
                                                                    runat="server" meta:resourcekey="lblInHandQtyResource1"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        
                                                         <asp:BoundField HeaderText="SellingUnit" DataField="Unit"  meta:resourcekey="BoundFieldResource4" />
                                                      <%--  <asp:TemplateField HeaderText="Units">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlUnit" runat="server" Width="70px">
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hdnUnit" Value='<%# Eval("Unit") %>' runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                         
                                                        <asp:BoundField HeaderText="ProductKey" DataField="ProductKey" Visible="false" meta:resourcekey="BoundFieldResource5"   />
                                                        
                                                        
                                                    </Columns>
                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="dataheader1" />
                                                </asp:GridView>
                                    </td>
                                </tr>
                                
                                 <tr>
                                    <td colspan="3">
                                        <asp:GridView ID="GridViewDetail" EmptyDataText="No matching records found " runat="server"
                                                    AutoGenerateColumns="False" class="w-100p custcellpadding3 custcellspacing2"
                                                    meta:resourcekey="GridViewDetailResource1" >
                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <Columns>
                                                    
                                                 
                                                <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                                                     
                                                        <asp:HiddenField ID="hdnBatchNo" runat="server" 
                                                            Value='<%# bind("BatchNo") %>' />
                                                        <asp:HiddenField ID="hdnProductID" runat="server" 
                                                            Value='<%# bind("ProductID") %>' />
                                                        <asp:HiddenField ID="hdnpProductKey" runat="server" 
                                                            Value='<%# bind("ProductKey") %>' />
                                                        <asp:HiddenField ID="hdnpInHandQuantity" runat="server" 
                                                            Value='<%# bind("InHandQuantity") %>' />
                                                       
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                  
                                                        <%--<asp:BoundField HeaderText="SRD No" DataField="Description"  />--%>
                                                        <asp:BoundField HeaderText="Product Name" DataField="ProductName"  meta:resourcekey="BoundFieldResource6" />
                                                        <asp:BoundField HeaderText="Invoice No" DataField="InvoiceNo" meta:resourcekey="BoundFieldResource7"  />
                                                        <asp:BoundField HeaderText="DcNo" DataField="DCNo"  meta:resourcekey="BoundFieldResource8" />
                                                        <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" Visible="True" meta:resourcekey="BoundFieldResource9"/>
                                                        <asp:BoundField HeaderText="SellingUnit" DataField="Unit"  meta:resourcekey="BoundFieldResource10" >
                                                        <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="ReturnQty" DataField="Quantity"  meta:resourcekey="BoundFieldResource11" >
                                                        <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                         <asp:BoundField HeaderText="Amount" DataField="Amount" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource12" >
                                                        <ItemStyle  HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                         
                                                        
                                                    </Columns>
                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="dataheader1" />
                                                </asp:GridView>
                                    </td>
                                </tr>
                              <tr>
                              <td colspan="2" class="a-right" >
                                <asp:Label ID="lblamont" runat="server" Text="Total Amount" Font-Bold="True" 
                                      meta:resourcekey="lblamontResource1"/>
                              </td>
                              <td class="a-right">
                                <asp:Label ID="lblReturnamount" runat="server" 
                                      meta:resourcekey="lblReturnamountResource1"  />
                              </td>
                              </tr>
                                
                                <tr id="approvalTR" class="hide"  runat="server">
                                    <td colspan="2">
                                        <table  class="w-100p custcellspacing1 border1 custcellpadding4" >
                                            <tr>
                                                <td class="bold a-left style5">
                                                    
                                                     <asp:Label ID="Label2" runat="server" Text="Approved Date :" 
                                                         meta:resourcekey="Label2Resource1"></asp:Label>
                                                </td>
                                                <td  class="a-left">
                                                      <asp:Label ID="approvedDateTD" runat="server" 
                                                          meta:resourcekey="approvedDateTDResource1"></asp:Label>
                                                
                                                </td>
                                                <td>
                                                </td>
                                                <td id="ReturnamountTD" class="a-left" runat="server">
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td class="a-left bold"  >
                                                   
                                                     <asp:Label ID="Label1" Text ="Approved By :" runat="server" 
                                                         meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td class="a-left" >
                                                <asp:Label ID="approvedByTD" runat="server" 
                                                        meta:resourcekey="approvedByTDResource1"></asp:Label>
                                                
                                                </td>
                                                  <td>
                                                </td>
                                                <td>
                                                </td>
                                                
                                            </tr>
                                                                             
                                            
                                        </table>
                                     
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="lblMessage" runat="server" 
                                            meta:resourcekey="lblMessageResource1"></asp:Label>
                                    </td>
                                </tr>
                                
                                  <tr>
                                    <td colspan="3">
                                        <table  class="w-100p custcellspacing1 border1 custcellpadding4">
                                            <tr>
                                                <td class="a-right hide" >
                                                    <asp:Button ID="btnUpdate" Text="Update" 
                                        runat="server" CssClass="btn w-50" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnUpdate_Click"  meta:resourcekey="btnUpdateResource1"/>
                                               <asp:Button ID="btnApprove" Text="Approve" runat="server" onmouseover="this.className='btn btnhov'"
                                                    CssClass="btn" onmouseout="this.className='btn'" OnClick="btnApprove_Click" meta:resourcekey="btnApproveResource1"/>
                                                </td>
                                                </tr><tr>
                                                <td class="a-center" > 
                                                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                        runat="server" CssClass="btn w-40" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'"  meta:resourcekey="btnPrintResource1" />
                                                    <input type="hidden" id="hdnApproveStockReturn" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                         </td></tr></table>
                        </div>
                        
                      
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />             
     <asp:HiddenField ID="hdnTableData" Value="" runat="server" />
     <asp:HiddenField ID="hdnCount" Value="0" runat="server" />
    </form>
    
     <script language="javascript" type="text/javascript">
         function ValidateReturnQty(avilableQty, ReturnQuantity) {
           
             var pavilableQty = document.getElementById(avilableQty).value;
             var pReturnQuantity = document.getElementById(ReturnQuantity).value;
             var UserMsg = SListForAppMsg.Get('InventorySales_ViewSalesReturn_aspx_01') != null ? SListForAppMsg.Get('InventorySales_ViewSalesReturn_aspx_01') : "Provide return quantity less than or equal to Avilable quantity";
             var Information = SListForAppMsg.Get('InventorySales_ViewSalesReturn_Error') != null ? SListForAppMsg.Get('InventorySales_ViewSalesReturn_Error') : "Error";
             if (Number(pavilableQty) < Number(pReturnQuantity)) 
             {

                 ValidationWindow(UserMsg,);
                 //document.getElementById(ReturnQuantity).value = Number(pIssuedQuantity).toFixed(2);
                 document.getElementById(ReturnQuantity).value = '';
                 document.getElementById(ReturnQuantity).focus();
                 return false;
             }

         }
    </script>
</body>
</html>
