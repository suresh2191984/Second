<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="ViewStockReceived.aspx.cs"
    Inherits="StockReceived_ViewStockReceived" meta:resourcekey="PageResource2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Stock Received</title>
    <%--<link href="../PlatForm/StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--    <script src="../PlatForm/Scripts/Common.js" language="javascript" type="text/javascript"></script>
    <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>--%>

    <style type="text/css">
        .style1
        {
            width: 1362px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divReceived" runat="server">
            <table class="w-100p" style="width:100% !important;" >
                <tr>
                    <td class="a-center bold" colspan="2">
                        <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_StockReceived%> --%>
                        <asp:Label ID="lblStockReceived" CssClass="font16"  runat="server" Text="Stock Received" meta:resourcekey="lblStockReceivedResource2"></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="a-center bold" colspan="4">
                        <asp:Image ID="imgBillLogo" runat="server" />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="w-85p paddingL10" style="width:85% !important;" >
                        <table class="w-100p a-left">
                            <tr class="a-left">
                                <td>
                                    <asp:Label ID="lblFrom" CssClass="bold" runat="server"
                                        Text="From" meta:resourcekey="lblFromResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgName" CssClass="bold font11" runat="server" meta:resourcekey="lblOrgNameResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgTinnotxt" CssClass="bold" Text="TIN No :" runat="server" meta:resourcekey="lblOrgTinnotxtResource2"></asp:Label>
                                    <asp:Label ID="lblOrgTinno" runat="server" meta:resourcekey="lblOrgTinnoResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgDlnotxt" CssClass="bold" Text="DL No :" runat="server" meta:resourcekey="lblOrgDlnotxtResource2"></asp:Label>
                                    <asp:Label ID="lblorgDlno" runat="server" meta:resourcekey="lblorgDlnoResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="h-10">
                                </td>
                            </tr>
                            <tr class="a-left">
                                <td>
                                    <asp:Label ID="lblTo" runat="server" CssClass="bold" Text="To"
                                        meta:resourcekey="lblToResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorName" CssClass="bold font11" runat="server" meta:resourcekey="lblVendorNameResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr  id="trtinno" runat="server" style="display:none;">
                                <td>
                                    <asp:Label ID="lblVendorTinnotxt" CssClass="bold" Text="TIN No :" runat="server"
                                        meta:resourcekey="lblVendorTinnotxtResource2"></asp:Label>
                                    <asp:Label ID="lblVendorTinno" runat="server" meta:resourcekey="lblVendorTinnoResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trgstinno" runat="server">
                                <td>
                                    <asp:Label ID="lblgstin" Font-Bold="True" Text="GSTIN No :" 
                                        runat="server" meta:resourcekey="lblgstinResource2"></asp:Label>
                                    <asp:Label ID="lblgstinno" runat="server" 
                                        meta:resourcekey="lblgstinnoResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorAddress" runat="server" meta:resourcekey="lblVendorAddressResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorCity" runat="server" meta:resourcekey="lblVendorCityResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="a-right w-15p" style="width:15% !important;" >
                        <table>
                            <tr>
                                <td class="a-left w-40p">
                                    <asp:Label ID="lblDate" runat="server" CssClass="bold" Text="Stock Received Date" meta:resourcekey="lblDateResource2"></asp:Label>
                                </td>
                                <td class="w-1p">
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblSRDate" runat="server" meta:resourcekey="lblSRDateResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblPONo" runat="server" CssClass="bold" Text="P.O No" meta:resourcekey="lblPONoResource2"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblReceivedNo" runat="server" CssClass="bold" Text="GRN" meta:resourcekey="lblReceivedNoResource2"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblReceivedID" runat="server" meta:resourcekey="lblReceivedIDResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblInvoiceNotxt" CssClass="bold" Text="Invoice No" runat="server" meta:resourcekey="lblInvoiceNotxtResource2"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblInvoiceNo" runat="server" meta:resourcekey="lblInvoiceNoResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="Label1" Text="DC No" CssClass="bold" runat="server" meta:resourcekey="Label1Resource2"></asp:Label>
                                    <asp:Label ID="lblDCNumber" CssClass="hide" runat="server" Text="Ref. Inv No."
                                        meta:resourcekey="lblDCNumberResource1"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblDCNo" runat="server" meta:resourcekey="lblDCNoResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblStatustxt" runat="server" CssClass="bold" Text="Status" meta:resourcekey="lblStatustxtResource2"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource2"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblInvoiceDatetxt" runat="server" CssClass="bold" Text="Invoice Date" meta:resourcekey="lblInvoiceDatetxtResource2"></asp:Label>
                                </td>
                                <td>
                                    :
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblInvoiceDate" runat="server" meta:resourcekey="lblInvoiceDateResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="w-20">
                                   
                                </td>
                            </tr>
                            <%-- <tr>
                                                <td colspan="2" align="left">
                                                    <table cellpadding="4" cellspacing="4">
                                                        <tr>
                                                            <td valign="top">
                                                                Note :
                                                            </td>
                                                            <td valign="bottom">
                                                                * No Batch No.<br />
                                                                ** No Exp or Mft Date.
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>--%>
                        </table>
                    </td>
                </tr>
            </table>
            <table class="w-100p">
                <tr>
                    <td class="w-15" colspan="3">
                        <asp:HiddenField ID="hdnIsResdCalc" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:GridView CssClass="hide" EmptyDataText="No matching records found " ID="grdResult" runat="server"
                            AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound"
                            class="gridView w-100p" meta:resourcekey="grdResultResource2">
                            <Columns>
                                <asp:BoundField HeaderText="Product" DataField="ProductName" meta:resourcekey="BoundFieldResource10" />
                                <asp:BoundField HeaderText="Batch No" DataField="BatchNo" meta:resourcekey="BoundFieldResource11" />
                                <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        MFT :
                                        <%# (Eval("Manufacture", "{0:yyyy}") == "1753" || Eval("Manufacture", "{0:yyyy}") == "9999" ||Eval("Manufacture", "{0:yyyy}") == "0001" ) ? "**" : GetDate(Eval("Manufacture", "{0:MMM-yyyy}"))%><br />
                                        EXP :
                                        <%# ((Eval("ExpiryDate", "{0:yyyy}")) == "1753" || (Eval("ExpiryDate", "{0:yyyy}")) == "9999" || (Eval("ExpiryDate", "{0:yyyy}")) == "0001") ? "**" : GetDate(Eval("ExpiryDate"))%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PO Qty" meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <%# Eval("POQuantity")%>
                                        (<%# Eval("POUnit")%>)
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rcvd Qty(lsu)" meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <%# Eval("RcvdLSUQty")%>
                                        (<%# Eval("SellingUnit")%>)
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comp Qty(lsu)" meta:resourcekey="TemplateFieldResource8">
                                    <ItemTemplate>
                                        <%# Eval("ComplimentQTY")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Cost Price" DataField="UnitCostPrice" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource12"></asp:BoundField>
                                <asp:BoundField HeaderText="Nominal" DataField="ActualAmount" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource2">
                                    <ItemStyle CssClass="hide" />
                                    <HeaderStyle CssClass="hide" />
                                </asp:BoundField>
                                <%--     <asp:TemplateField HeaderText="Cost Price">
                                                    <ItemTemplate>
                                                        <%# Eval("UnitCostPrice")%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                                <asp:BoundField HeaderText="Scheme" DataField="SchemeDisc" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" ></asp:BoundField>
                                <asp:BoundField HeaderText="Discount" DataField="Discount" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource13"></asp:BoundField>
                                <asp:BoundField HeaderText="Ex (%)" DataField="ExciseTax" Visible="false" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource14"></asp:BoundField>
                                <asp:BoundField HeaderText="Tax (%)" DataField="Tax" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource15"></asp:BoundField>
                                <asp:BoundField HeaderText="PurchaseTax(%)" DataField="PurchaseTax" Visible="false"   ItemStyle-HorizontalAlign="Right"
                                               meta:resourcekey="BoundFieldResource19"       />
                                <asp:BoundField HeaderText="Selling Price" DataField="UnitSellingPrice" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource16"></asp:BoundField>
                                <%--     <asp:TemplateField HeaderText="Selling Price"  >
                                                    <ItemTemplate>
                                                        <%# Eval("UnitSellingPrice")%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                <asp:BoundField HeaderText="MRP/SRP" DataField="MRP" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource17"></asp:BoundField>
                                <asp:BoundField HeaderText="Total Cost" DataField="TotalCost" ItemStyle-HorizontalAlign="Right"
                                    DataFormatString="{0:N}" meta:resourcekey="BoundFieldResource18"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <input id="hdnCollectedItems" runat="server" type="hidden" />
                        <input id="hdnConsumableItems" runat="server" type="hidden" />
                        <input id="hdnStatus" runat="server" type="hidden" />
                        <asp:DataList ID="grdstock" Width="100%" runat="server">
                                        
                        <HeaderTemplate>
                                            
                                <table width="100%" cellspacing="0" rules="all" border="1" style="margin-top: 10px;color:#333333;width:100%;border-collapse:collapse;">
                                    <tr>
                                        <th rowspan="3">
                                            Product
                                        </th>
                                        <th  rowspan="3">
                                        HSN Code
                                        </th>
                                        <th rowspan="3">
                                            Batch No
                                        </th>
                                        <th rowspan="3">
                                            Date
                                        </th>
                                        <th rowspan="3">
                                            PO Qty
                                        </th>
                                        <th rowspan="3">
                                            Rcvd Qty(lsu)
                                        </th>
                                        <th rowspan="3">
                                            Comp Qty(lsu)
                                        </th>
                                        <th rowspan="3">
                                            Cost Price
                                        </th>
                                        <th rowspan="3"  style="display:none;">
                                            Nominal
                                        </th>
                                        <th colspan="2">
                                            Scheme
                                        </th>
                                        <th colspan="2">
                                            Discount
                                        </th>
                                        <th rowspan="3" style="display:none;">
                                            Ex (%)
                                        </th>
                                        <th rowspan="3" style="display:none;">
                                            Tax (%)
                                        </th>
                                        <th colspan="6">
                                            GST
                                        </th>
                                        <th rowspan="3">
                                            Selling Price
                                        </th>
                                        <th rowspan="3">
                                            MRP
                                        </th>
                                        <th rowspan="3">
                                            Total Cost
                                        </th>
                                    </tr>
                                    <tr>
                                        <th rowspan="2">
                                            %
                                        </th>
                                        <th rowspan="2">
                                            Amt
                                        </th>
                                        <th rowspan="2">
                                            %
                                        </th>
                                        <th rowspan="2">
                                            Amt
                                        </th>
                                        <th colspan="2">
                                            CGST
                                        </th>
                                        <th colspan="2">
                                            SGST
                                        </th>
                                        <th colspan="2">
                                            IGST
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>%</th>
                                        <th>Amt</th>
                                        <th>%</th>
                                        <th>Amt</th>
                                        <th>%</th>
                                        <th>Amt</th>
                                    </tr>
                                                    
                                        </HeaderTemplate>       
                            <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%#Eval("ProductName")%>
                                        </td>
                                        <td>
                                            <%#Eval("Remarks")%>
                                        </td>
                                        <td>
                                            <%#Eval("BatchNo")%>
                                        </td>
                                        <td>
                                             MFT :
                                        <%# (Eval("Manufacture", "{0:yyyy}") == "1753" || Eval("Manufacture", "{0:yyyy}") == "9999" ||Eval("Manufacture", "{0:yyyy}") == "0001" ) ? "**" : GetDate(Eval("Manufacture", "{0:MMM-yyyy}"))%><br />
                                        EXP :
                                        <%# ((Eval("ExpiryDate", "{0:yyyy}")) == "1753" || (Eval("ExpiryDate", "{0:yyyy}")) == "9999" || (Eval("ExpiryDate", "{0:yyyy}")) == "0001") ? "**" : GetDate(Eval("ExpiryDate"))%>
                                        </td>
                                        <td>
                                            <%# Eval("POQuantity")%>
                                            (<%# Eval("POUnit")%>)
                                        </td>
                                        <td>
                                            <%# Eval("RcvdLSUQty")%>
                                            (<%# Eval("SellingUnit")%>)
                                        </td>
                                        <td>
                                            <%# Eval("ComplimentQTY")%>
                                        </td>
                                        <td>
                                            <%# string.Format("{0:n}", Eval("UnitCostPrice"))%>
                                        </td>
                                        <td style="display:none;">
                                            <%# string.Format("{0:n}", Eval("ActualAmount"))%>
                                        </td>
                                         <td>
                                          <%# string.Format("{0:n}", Eval("SchemeType"))%>
                                                           
                                        </td>
                                         <td>
                                          <%# string.Format("{0:n}", Eval("SchemeDisc"))%> 
                                                           
                                        </td>
                                        <td>
                                         <%# string.Format("{0:n}", Eval("DiscountType"))%> 
                                                           
                                        </td>
                                        <td>
                                         <%# string.Format("{0:n}", Eval("Discount"))%> 
                                                          
                                        </td>
                                        <td style="display:none;">
                                        <%# string.Format("{0:n}", Eval("ExciseTax"))%>
                                                           
                                        </td>
                                        <td style="display:none;">
                                            <%# string.Format("{0:n}", Eval("Tax"))%>
                                                          
                                        </td>
                                        <td>
                                            <%# string.Format("{0:n}", Eval("CGSTPercent"))%>
                                                            
                                        </td>
                                        <td>
                                        <%# string.Format("{0:n}", Eval("CGSTRate"))%>
                                                            
                                        </td>
                                        <td>
                                            <%# string.Format("{0:n}", Eval("SGSTPercent"))%>
                                                            
                                        </td>
                                        <td>
                                            <%# string.Format("{0:n}", Eval("SGSTRate"))%>
                                                            
                                        </td>
                                            <td>
                                            <%# string.Format("{0:n}", Eval("IGSTPercent"))%>
                                                            
                                        </td>
                                        <td>
                                            <%# string.Format("{0:n}", Eval("IGSTRate"))%>
                                                            
                                        </td>
                                        <td>
                                        <%# string.Format("{0:n}", Eval("UnitSellingPrice"))%>
                                                           
                                        </td>
                                        <td>
                                        <%# string.Format("{0:n}", Eval("MRP"))%>
                                                           
                                        </td>
                                        <td>
                                        <%# string.Format("{0:n}", Eval("TotalCost"))%>
                                                          
                                        </td>
                                    </tr>
                                                
                            </ItemTemplate>
                            <ItemStyle CssClass="hide" />
                            <FooterTemplate>
                            </table>
                            </FooterTemplate>
                            <FooterStyle CssClass="hide" />
                        </asp:DataList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="a-left w-80p v-bottom"  >
                        <table cellpadding="4" cellspacing="4">
                           <tr>
                <td align="left" colspan="2">
                   
              



                
                   <asp:DataList ID="grdGstTax" Width="100%" runat="server" align="center"   
      >
                                        
                    <HeaderTemplate>
                       
                <table cellspacing="0" rules="all" border="1" style="color:#333333;width:75%;border-collapse:collapse;" class="w-100p">
              <tr>
              <td colspan="7" align="center"  > 
              
                         <b>  <center>GST Tax Breakup Details</center></b>    
                            </td>
              </tr> 
<tr> 
<th rowspan="2" >Taxable<br /> Value</th>
<th colspan="2">
                                            CGST
                                        </th>
                                        <th colspan="2">
                                            SGST
                                        </th>
                                        <th colspan="2">
                                            IGST
                                        </th></tr>
 <tr>

                                        <th >
                                            %
                                        </th>
                                        <th >
                                            Amount
                                        </th>
                                       <th >
                                            %
                                        </th>
                                        <th >
                                            Amount
                                        </th>
                                       <th >
                                            %
                                        </th>
                                        <th >
                                            Amount
                                        </th>
                                    </tr>

   </HeaderTemplate>       
                            <ItemTemplate>
<tr> <td class="a-right" style="height:25px;">     <%# string.Format("{0:n}", Eval("TaxableValue"))%></td>
     <td class="a-center">
                                            <%# string.Format("{0:n}", Eval("CGSTPercent"))%>
                                                            
                                        </td>
                                        <td class="a-right">
                                        <%# string.Format("{0:n}", Eval("CGSTRate"))%>
                                                            
                                        </td>
                                        <td class="a-center">
                                            <%# string.Format("{0:n}", Eval("SGSTPercent"))%>
                                                            
                                        </td>
                                        <td class="a-right">
                                            <%# string.Format("{0:n}", Eval("SGSTRate"))%>
                                                            
                                        </td>
                                            <td class="a-center">
                                            <%# string.Format("{0:n}", Eval("IGSTPercent"))%>
                                                            
                                        </td>
                                        <td class="a-right">
                                            <%# string.Format("{0:n}", Eval("IGSTRate"))%>
                                                            
                                        </td>
             
               
              
  
   </ItemTemplate>
   
                            <ItemStyle CssClass="hide" />
                            <FooterTemplate>
                            </tr>
                          
                            </table>
                            </FooterTemplate>
                            <FooterStyle CssClass="hide" />
                            
                        </asp:DataList>
                
                
                                 
                  
                         </td>
                </tr>
               <tr>
                                 <td >
                                <asp:Label ID="lblTotalTaxablevalue" runat="server" meta:resourceKey="lblTotalTaxablevalueResource2"
                                  Visible=false   ></asp:Label> <br /> <asp:Label ID="lblTotalCGSTAmount" runat="server" meta:resourceKey="lblTotalCGSTAmountResource2"   Visible=false 
                                     ></asp:Label></td>
                                    <td   >
                                <asp:Label ID="lblTotalSGSTAmount" runat="server" meta:resourceKey="lblTotalSGSTAmountResource1"   Visible=false 
                                    ></asp:Label><br /><asp:Label ID="lblTotalIGSTAmount" runat="server" meta:resourceKey="lblTotalIGSTAmountResource1"   Visible="false">
                                    </asp:Label> </td> </tr>
                        
                        
                            <tr>
                                <td class="v-top">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_Note%> --%>
                                    <asp:Label ID="lblNote" runat="server" CssClass="bold" Text="Note :" meta:resourcekey="lblNoteResource2"></asp:Label>
                                </td>
                                <td class="v-bottom">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_NoBatchNo%> --%>
                                    <asp:Label ID="lblNoBatchNo" runat="server" Text="* No Batch No." meta:resourcekey="lblNoBatchNoResource2"></asp:Label>
                                    <br />
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_NoExporMftDate%> --%>
                                    <asp:Label ID="lblNoExporMftDate" CssClass="marginT10" runat="server" Text="** No Exp or Mft Date." meta:resourcekey="lblNoExporMftDateResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="a-right w-20p" style="width:20% !important; text-align:right !important;">
                        <table id="tblAmountDetails" runat="server" class="w-100p a-right" cellspacing="5">
                            <tr>
                                <td class="a-left">
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_TotalSales%>--%>
                                    <asp:Label ID="lblTotalSales2" runat="server" Text="Total Sales" meta:resourcekey="lblTotalSales2Resource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblTotalSales" runat="server" Text="0.00" meta:resourcekey="lblTotalSalesResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                               <td class="a-left">
                                 <asp:Label ID="lblTotalSchemeAmt" runat="server" Text="Scheme Discount"
                                  meta:resoucekey="lblTotalSchemeAmtResource1"></asp:Label>
                               </td>
                               <td class="a-right">
                                 <asp:Label ID="lblTotalSchemeDisc" runat="server" Text="0.00"></asp:Label>
                               </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_TotalDiscountAmount%>--%>
                                    <asp:Label ID="lblTotalDiscountAmount" runat="server" Text="Discount"
                                        meta:resourcekey="lblTotalDiscountAmountResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblTotalDiscount" runat="server" Text="0.00" meta:resourcekey="lblTotalDiscountResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                              <td class="a-left">
                                <asp:Label ID="lblAmtBeforeTax" runat="server" Text="Amount Before Tax" meta:resoucekey="lblAmtBeforeTaxResource1"> </asp:Label>
                              </td>
                              <td class="a-right">
                                <asp:Label ID="lblAmtBefTax" runat="server" Text="0.00"></asp:Label>
                              </td>
                            </tr>
                            <tr id="trcgst" runat="server">
                                <td  align="left">
                                   <asp:Label ID="lbltotcgst" runat="server" Text="Total CGST" meta:resourcekey="lbltotcgstResource1"></asp:Label>&nbsp;&nbsp;
                                </td>
                                <td align="right">
                                   <asp:Label ID="lbltotcgstamt" runat="server" Text="0.00" ></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr id="trsgst" runat="server">
                                <td  align="left">
                                <asp:Label ID="lbltotsgst" runat="server" Text="Total SGST" meta:resourcekey="lbltotsgstResource1"></asp:Label>&nbsp;&nbsp;
                                </td>
                                <td align="right">
                                <asp:Label ID="lbltotsgstamt" runat="server" Text="0.00" ></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr id="trigst" runat="server">
                                <td  align="left">
                                <asp:Label ID="lbltotigst" runat="server" Text="Total IGST" meta:resourcekey="lbltotigstResource1"></asp:Label>&nbsp;&nbsp;
                                </td>
                                <td align="right">
                                <asp:Label ID="lbltotigstamt" runat="server" Text="0.00" ></asp:Label>&nbsp;
                                </td>
                            </tr>
                            <tr id="totalTaxAmt" runat="server">
                                <td class="a-left">
                                    
                                    <asp:Label ID="lblTotalTaxAmount" runat="server" Text="Total GST Amount" meta:resourcekey="lblTotalTaxAmountResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblTotaltax" runat="server" Text="0.00" meta:resourcekey="lblTotaltaxResource2"></asp:Label>
                                </td>
                            </tr>
                            
                              <tr id="TrTCS" runat="server" class="hide">
                                <td class="a-left">
                                   
                                  <asp:Label ID="lblTCS" runat="server" Text="Total TCS Amount" meta:resourcekey="lbllblTCSResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblTCSValue" runat="server" Text="0.00" meta:resourcekey="lblTCSValueResource2"></asp:Label>
                                </td>
                            </tr>
                            
                            <tr>
                              <td class="a-left">
                                <asp:Label ID="lblAmtAfterTax" runat="server" Text="Amount After Tax" meta:resoucekey="lblAmtAfterTaxResource1"></asp:Label>
                              </td>
                              <td class="a-right">
                                <asp:Label ID="lblAmtAftTax" runat="server" Text="0.00"></asp:Label>
                              </td>
                            </tr>
                            <tr id="lbltotalExe" runat="server" class="hide">
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_TotalExcise%>--%>
                                    <asp:Label ID="lblTotalExcise2" runat="server" Text="Total Excise" meta:resourcekey="lblTotalExcise2Resource1"></asp:Label>
                                    
                                </td>
                                <td class="a-left">
                                    <asp:Label ID="lblTotalExcise" runat="server" Text="0.00" meta:resourcekey="lblTotalExciseResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trCess2" runat="server" class="hide">
                                <td class="a-left">
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_CessOnExcise2%>--%>
                                    <asp:Label ID="lblCessOnExcise2" runat="server" Text="CessOnExcise2" meta:resourcekey="lblCessOnExcise2Resource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblCessOnExcise" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblCessOnExciseResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trEdCess1" runat="server" class="hide">
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_HighterEdCess%>--%>
                                    <asp:Label ID="lblHighterEdCess2" runat="server" Text="HighterEdCess" meta:resourcekey="lblHighterEdCess2Resource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblHighterEdCess" runat="server" Text="0.00" meta:resourcekey="lblHighterEdCessResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="lblcst5" class="hide">
                                <td class="a-left">
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_CST5%>--%>
                                    <asp:Label ID="lblCST1" runat="server" Text="CST5" meta:resourcekey="lblCST5Resource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblCST" runat="server" Text="0.00" meta:resourcekey="lblCSTResource2"></asp:Label>
                                </td>
                            </tr>
                            <br />
                            <tr id="lblSupplierSerTax" runat="server" class="hide">
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_SupplierServiceTax%>--%>
                                    <asp:Label ID="lblSupplierServiceTax" runat="server" Text="Supplier Service Tax"
                                        meta:resourcekey="lblSupplierServiceTaxResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblTax" runat="server" Text="0.00" meta:resourcekey="lblTaxResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="trpodiscount">
                                <td class="a-left">
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_PODiscount%>--%>
                                    <asp:Label ID="lblPODiscount2" runat="server" Text="PO Discount" meta:resourcekey="lblPODiscount2Resource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblDiscount" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblDiscountResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_CreditAmountToBeUsed%>--%>
                                    <asp:Label ID="lblCreditAmountToBeUsed2" runat="server" Text="Credit Amount To Be Used"
                                        meta:resourcekey="lblCreditAmountToBeUsed2Resource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblamountused" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblamountusedResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_Total%>--%>
                                    <asp:Label ID="lblTotal" runat="server" Text="Total" meta:resourcekey="lblTotalResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblGrountTotal" runat="server" Text="0.00" meta:resourcekey="lblGrountTotalResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trStampFee" runat="server">
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_CreditAmountToBeUsed%>--%>
                                    <asp:Label ID="lblStampFee" runat="server" Text="Stamp Fee" meta:resourcekey="lblStampFeeResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblStampFeeused" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblStampFeeResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trDeliveryCharges" runat="server">
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_CreditAmountToBeUsed%>--%>
                                    <asp:Label ID="lblDeliveryCharges" runat="server" Text="Delivery Charges" meta:resourcekey="lblDeliveryChargesResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblDeliveryChargesUsed" Width="50px" runat="server" Text="0.00" meta:resourcekey="lblDeliveryChargesResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_RoundOffValue%>--%>
                                    <asp:Label ID="lblRoundOffValue1" runat="server" Text="RoundOff Value" meta:resourcekey="lblRoundOffValueResource2"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblRoundOffValue" runat="server" Text="0.00" meta:resourcekey="lblRoundOffValueResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <%--<%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_GrandTotal%>--%>
                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Grand Total" class="bold" meta:resourcekey="lblGrandTotalResource1"></asp:Label>
                                    
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblGrandwithRoundof" runat="server" Text="0.00" class="bold"  meta:resourcekey="lblGrandwithRoundofResource2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
        
                <tr>
                    <td colspan="3" id="commentsTD" runat="server">
                    </td>
                </tr>
                <tr id="approvalTR" class="hide" runat="server">
                    <td colspan="3">
                        <table class="w-100p">
                            <tr>
                                <td class="bold w-8p">
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_ApprovedDate%>--%>
                                    <asp:Label ID="lblApprovedDate" runat="server" Text="Approved Date" meta:resourcekey="lblApprovedDateResource1"></asp:Label>
                                </td>
                                <td id="approvedDateTD" class="a-left bold w-80p" runat="server">
                                </td>
                            </tr>
                           <%-- <tr>
                                <td class="bold">
                                    <%-- <%=Resources.ClientSideDisplayTexts.Inventory_ViewStockReceived_ApprovedBy%>
                                    <asp:Label ID="lblApprovedBy2" runat="server" Text="Approved By" meta:resourcekey="lblApprovedBy2Resource1"></asp:Label>
                                </td>
                                <td id="approvedByTD" class="a-left w-80p" runat="server">
                                </td>
                            </tr>--%>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="h-10" colspan="3">
                    </td>
                </tr>
                <tr>
                    <td class="a-center" colspan="3">
                        <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource2"></asp:Label>
                    </td>
                </tr>
            </table>
            <table class="w-100p">
                <tr>
                    <td class="w-50p bold">
                        <asp:Label class="bold" ID="lblSign" runat="server" Text="<br><br>Prepared By" meta:resourcekey="lblSignResource1"></asp:Label>
                    </td>
                    <td class="w-35p bold">
                        <asp:Label class="bold" ID="lblauthorized" runat="server" Text="<br><br>Authorized By"
                            meta:resourcekey="lblauthorizedResource1"></asp:Label>
                    </td>
                    <td class="w-28p bold">
                        <asp:Label class="bold" ID="lblapproved" runat="server" Text="<br><br>Approved By"
                            meta:resourcekey="lblapprovedResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                 <%--<td class="w-50p bold">
                        <asp:Label class="bold" ID="lblPreparedbyVal" runat="server"  meta:resourcekey="lblPreparedbyValResource1"></asp:Label>
                    </td>
                    <td class="w-35p bold">
                        <asp:Label class="bold" ID="lblauthorizedVal" runat="server" 
                            meta:resourcekey="lblauthorizedValResource1"></asp:Label>
                    </td>
                    <td class="w-28p bold">
                        <asp:Label class="bold" ID="lblapprovedVal" runat="server" 
                            meta:resourcekey="lblapprovedValResource1"></asp:Label>
                    </td>--%>
                    
                </tr>
                <%-- added  for approved by user name 17:05:2017--%>
                 <tr>
                    <td class="w-50p bold" id="lblPreparedbyVal"  runat="server">
                        
                    </td>
                    <td class="w-35p bold" id="lblauthorizedVal" runat="server" >
                        
                    </td>
                    <td  id="approvedByTD" class="w-28p bold" runat="server">
                        
                    </td>
                </tr>

            </table>
        </div>
        <br />
        <table class="w-100p">
            <tr>
                <td class="a-right w-45p">
                    <table id="trApproveBlock" class="hide w-100p" runat="server">
                        <tr>
                            <td>
                                <input type="hidden" id="hdnApproveStockReceived" runat="server" />
                                <asp:Button ID="btnApprove" Text="Approve" runat="server" 
                                    CssClass="btn" OnClick="btnApprove_Click" meta:resourcekey="btnApproveResource2" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="w-55p">
                    <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="cancel-btn" OnClick="btnBack_Click"
                        meta:resourcekey="btnBackResource2" />
                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                         runat="server" CssClass="btn" meta:resourcekey="btnPrintResource2" />
                    <asp:Button ID="btnInvoice" Text="MatchingInvoice" runat="server" CssClass="btn"
                        OnClick="btnInvoice_Click" meta:resourcekey="btnInvoiceResource2" />
                </td>
                <td>
                    <asp:Button ID="btnBarCode" Text="ViewBarCode" runat="server" CssClass="btn hide"
                        OnClientClick="return Showpopup();" meta:resourcekey="btnBarCodeResource1" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divViewBarCode" runat="server">
                        <table class="w-100p serachPanel">
                            <tr>
                                <td>
                                    <asp:Button ID="closebtn" runat="server" Text="Close" CssClass="cancel-btn" OnClientClick="return closepopup();"
                                        meta:resourcekey="closebtnResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="grdViewBarCode" runat="server" AutoGenerateColumns="False" class="gridView w-100p"
                                        meta:resourcekey="grdViewBarCodeResource1">
                                        <Columns>
                                            <asp:BoundField HeaderText="PurchaseOrderID" DataField="PurchaseOrderID" Visible="false"
                                                meta:resourcekey="BoundFieldResource3" />
                                            <asp:BoundField HeaderText="ProductId" DataField="ProductId" Visible="false" meta:resourcekey="BoundFieldResource4" />
                                            <asp:BoundField HeaderText="ProductName" DataField="ProductName" meta:resourcekey="BoundFieldResource5" />
                                            <asp:BoundField HeaderText="Barcode" DataField="Barcode" meta:resourcekey="BoundFieldResource6" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="overlaydiv" runat="server" class="overlay">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTaxcalcType" Value="" runat="server" />
    <asp:HiddenField ID="hdnREQCalcCompQTY" runat="server" Value="N" />
    <asp:HiddenField ID="hdnGridcount" runat="server" />
    <asp:HiddenField ID="hdnIsSchemeDiscount" runat="server" Value="N" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        //-------------Mani--------
        $(document).ready(function() {
            if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'ViewStockReceived') {
                $("#Attuneheader_TopHeader1_lblvalue").text("View Stock Received");
            }
        });
        //----------End------------
        function CallPrint() {
		$('#trStampFee').hide();
            $('#trDeliveryCharges').hide();
            $('#lblcst5').hide();
            $('#lbltotalExe').hide();
            $('#trCess2').hide();
            $('#trEdCess1').hide();
            var prtContent = document.getElementById('divReceived');
            var WinPrint = window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write('<html><head>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            setTimeout(function() {
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
            }, 1000);
            //WinPrint.close();
        }
        function closepopup() {
            $('#grdViewBarCode').hide();
            $('#divViewBarCode').hide();
            $('#overlaydiv').hide();
            return false;
        }
        function Showpopup() {

            var gridview = document.getElementById('hdnGridcount');
            if (gridview.value != "0") {
                $('#grdViewBarCode').show();
                $('#divViewBarCode').show();
                $('#overlaydiv').show();
            }
            else {
                var userMsg = SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_12") == null ? "Please map Barcode" : SListForAppMsg.Get("StockReceived_BarcodeMapping_aspx_12");
                ValidationWindow(userMsg, ErrorMsg);
            }

            return false;
        }
    </script>

</html>
