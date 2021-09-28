<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SupplierList.aspx.cs" Inherits="Inventory_SupplierList" %>

 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../PlatForm/Scripts/Common.js" language="javascript" type="text/javascript"></script>
      <script src ="../PlatForm/Scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
    <title>Products List</title>

    <script language="javascript" type="text/javascript">
             var  userMsg;
        function Setval(obj) {
            document.getElementById('hdnProductName').value = obj.name;
            document.getElementById('hdnProductid').value = obj.title;

        }
        function nameValidate() {
            if (document.getElementById('hdnProductName').value == "" && document.getElementById('hdnProductid').value == "") {
              userMsg = SListForApplicationMessages.Get('Inventory\\SupplierList.aspx_1');
                   if(userMsg !=null)
                          {
                                 alert (userMsg );
                             return false;
                                 
                           }  
            else{
                alert('Select the product');
                return false;
                }
            }
            window.parent.document.getElementById('hdnProductName').value = document.getElementById('hdnProductName').value;
            //window.parent.document.getElementById('txtProductName').value = document.getElementById('hdnProductName').value;
            window.parent.document.getElementById('hdnproductId').value = document.getElementById('hdnProductid').value;

            self.close();
            return false;
        }
        
        
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div style="display: none;">
        <%--<t1:Theme ID="Theme1" runat="server" />--%>
    </div>
    <%-- <div class="dataone">--%>
    <div class="contentdatapopup">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                   <%-- <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                    <asp:GridView ID="grdResult" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                        OnRowDataBound="grdResult_RowDataBound" DataKeyNames="ProductID" ForeColor="#333333"
                        GridLines="Both" CssClass="mytable1">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="2%" Visible="false" HeaderText="Select" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <input id="rdSel" name="<%#Eval("ProductName") %>" title='<%#Eval("Productid") %>'
                                        onclick="Setval(this)" type="radio" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="S.No">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ExpiryDate" DataFormatString="{0:dd/MMM/yyyy}" HeaderText="Rcvd Date"
                                HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="ProductName" HeaderText="Supplier" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-Width="20%" ItemStyle-HorizontalAlign="Left" />
                                 <asp:BoundField DataField="CategoryName" HeaderText="SRD No" HeaderStyle-HorizontalAlign="Left"
                            ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="RcvdLSUQty" HeaderText="Rcvd Qty" HeaderStyle-HorizontalAlign="Left"
                                ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="ComplimentQTY" HeaderText="Free Qty" HeaderStyle-HorizontalAlign="Left"
                                ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="UnitPrice" DataFormatString="{0:0.00}" HeaderText="Unit Price" HeaderStyle-HorizontalAlign="Left"
                                ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="SellingPrice" DataFormatString="{0:0.00}" HeaderText="Selling Price" HeaderStyle-HorizontalAlign="Left"
                                ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="SellingUnit" HeaderText="Selling Unit" HeaderStyle-HorizontalAlign="Left"
                                ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderText="Discount" HeaderStyle-HorizontalAlign="Left"
                            ItemStyle-HorizontalAlign="Left" />
                           
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr>
                <td align="center">
                    &nbsp;&nbsp;
                    <input type="hidden" id="hdnProductName" runat="server" />
                    <input type="hidden" id="hdnProductid" runat="server" />
                    <a style="cursor: pointer; text-decoration: none; font-weight: bold; color: Blue;"
                        href="javascript:window.close();">Close
                        <%-- <%=Resources.ClientSideDisplayTexts.Inventory_SuppliersList_CloseWindow%>--%>
                         </a>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
        </table>
    </div>
    <%-- </div>--%>
      <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </form>
</body>
</html>
