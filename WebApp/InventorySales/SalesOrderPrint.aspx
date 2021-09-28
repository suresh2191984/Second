<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesOrderPrint.aspx.cs"
    Inherits="InventorySales_SalesOrderPrint" meta:resourcekey="PageResource1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
  

    <script language="javascript" type="text/javascript">

        function CallPrint() {
            var prtContent = document.getElementById('divReceived');
            document.getElementById('divReceived').style.fontSize = "Smaller";
            //document.getElementById('btnPrint').style.display = "none";
            $('#btnPrint').removeClass().addClass('hide');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
  <Attune:Attuneheader ID="Attuneheader" runat="server" />
      <div class="contentdata">
                        <div id="divReceived">
                            <table class="w-100p font12 custfontfamily2 custcellspacing1 custcellpadding2">
                                <tr>
                                    <td>
                                        <center>
                                            <table class="w-80p">
                                                <tr>
                                                    <td colspan="3" class="style8 a-center">
                                                        <strong><asp:Label ID="lblSalesOrder" runat="server" Text="Sales Order" meta:resourcekey="lblSalesOrderResource"/></strong>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <%-- Header Left Hand Side--%>
                                                    <td colspan="2" class="a-left">
                                                        <div class="marginL30">
                                                            <table>
                                                                <tr>
                                                                    <td colspan="3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label6" runat="server" Font-Bold="True" Text="CustomerName" meta:resourcekey="Label6Resource"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label10" runat="server" Text=":" meta:resourcekey="Label10Resource"/>
                                                                    </td>
                                                                    <td class="style5">
                                                                        <asp:Label ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblOrgDL" runat="server" Font-Bold="True" Text="Address :" meta:resourcekey="lblOrgDLResource"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label12" runat="server" Text=":"  meta:resourcekey="Label12Resource1"  />
                                                                    </td>
                                                                    <td class="style5">
                                                                        <asp:Label ID="lbladdr1" runat="server" meta:resourcekey="lbladdr1Resource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                        <div class="marginL150">
                                                                            <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                        <div class="marginL105">
                                                                            <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Text="Fax" meta:resourcekey="Label9Resource"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label14" runat="server" Text=":" meta:resourcekey="Label14Resource1" />
                                                                    </td>
                                                                    <td class="style5">
                                                                        <asp:Label ID="lblFax" runat="server" meta:resourcekey="lblFaxResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label13" runat="server" Font-Bold="True" Text="Email" meta:resourcekey="Label13Resource"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label15" runat="server" Text=":" meta:resourcekey="Label15Resource1"/>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblemails" runat="server" meta:resourcekey="lblemailsResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label16" runat="server" Font-Bold="True" Text="Tin No" meta:resourcekey="Label16Resource"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label17" runat="server" Text=":" meta:resourcekey="Label17Resource1"  />
                                                                    </td>
                                                                    <td class="style5">
                                                                        <asp:Label ID="lbltinno" runat="server" meta:resourcekey="lbltinnoResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label19" runat="server" Font-Bold="True" Text="CST" meta:resourcekey="Label19Resource"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label20" runat="server" Text=":" meta:resourcekey="Label20Resource1"/>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblcstno" runat="server" meta:resourcekey="lblcstnoResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label36" runat="server" Font-Bold="True" Text="Contact Person :" meta:resourcekey="Label36Resource"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label37" runat="server" Text=":" meta:resourcekey="Label37Resource1"/>
                                                                    </td>
                                                                    <td class="style5">
                                                                        <asp:Label ID="lblcontactperson" runat="server" meta:resourcekey="lblcontactpersonResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <%-- ENd  Header Left Hand Side--%>
                                                    <%-- Header Right Hand Side--%>
                                                    <td class="style6 v-top a-left">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblorderdate" runat="server" Text="Order Date" CssClass="custfontwidth1" meta:resourcekey="lblorderdateResource"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="server" Text=":" meta:resourcekey="Label1Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblSODate" runat="server" meta:resourcekey="lblSODateResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label2" runat="server" Text="SalesOrder No" CssClass="custfontwidth1"
                                                                         meta:resourcekey="Label2Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label3" runat="server" Text=":" meta:resourcekey="Label3Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label4" runat="server" Text="Status" CssClass="custfontwidth1" meta:resourcekey="Label4Resource"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label5" runat="server" Text=":" meta:resourcekey="Label5Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label7" runat="server" Text="Phone" CssClass="custfontwidth1" meta:resourcekey="Label7Resource"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label8" runat="server" Text=":"  meta:resourcekey="Label8Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label11" runat="server" Text="Mobile" CssClass="custfontwidth1" meta:resourcekey="Label11Resource"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label18" runat="server" Text=":" meta:resourcekey="Label18Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblMobile" runat="server" meta:resourcekey="lblMobileResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <%-- END Header Right Hand Side--%>
                                                </tr>
                                                <%-- Gridview--%>
                                                <tr>
                                                    <td colspan="3">
                                                        <div class="marginL10">
                                                            <asp:GridView EmptyDataText="No matching records found " ID="grdResult"
                                                                runat="server" AutoGenerateColumns="False" ForeColor="#333333" class="w-97p" CssClass="mytable1 custcellspacing1"
                                                                Font-Names="verdana" Font-Size="Small" meta:resourcekey="grdResultResource1">
                                                                <HeaderStyle CssClass="dataheader1" Font-Names="verdana" Font-Size="Smaller" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <%#Container.DataItemIndex+1 %>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField HeaderText="Code" DataField="Attributes"  meta:resourcekey="BoundField1Resource"/>
                                                                    <asp:BoundField HeaderText="Description" DataField="ProductName" meta:resourcekey="BoundField2Resource"/>
                                                                    <asp:BoundField HeaderText="Make" DataField="CategoryName" meta:resourcekey="BoundField3Resource"/>
                                                                    <asp:TemplateField HeaderText="Qty" meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <%#Eval("Quantity") %>(<%# Eval("Unit")%>)
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField HeaderText="Qty" DataField="Quantity" Visible="false" meta:resourcekey="BoundField4Resource"/>
                                                                    <asp:BoundField HeaderText="UnitPrice" DataField="UnitPrice" meta:resourcekey="BoundField5Resource"/>
                                                                    <asp:BoundField HeaderText="Amount" DataField="Amount" meta:resourcekey="BoundField5Resource"/>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <%-- End Gridview--%>
                                                <tr>
                                                    <%-- Bottom Right Hand Side--%>
                                                    <td colspan="3">
                                                        <table class="w-100p marginL30">
                                                            <tr>
                                                                <td colspan="3" class="a-left" >
                                                                    <table>
                                                                        <tr >
                                                                            <td  class="hide"  >
                                                                                <asp:Label ID="Label21" runat="server" Font-Bold="True" Text="PurchaseOrder No. / Date " meta:resourcekey="Label21Resource"></asp:Label>
                                                                            </td>
                                                                            <td  class="hide" >
                                                                                <asp:Label ID="Label22" runat="server" meta:resourcekey="Label22Resource1"/>
                                                                            </td>
                                                                            <td  class="hide" >
                                                                                <asp:Label ID="lblPorderno" runat="server" meta:resourcekey="lblPordernoResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <%--<tr>
                                                                            <td>
                                                                                <asp:Label ID="Label23" runat="server" Font-Bold="True" Text="Invoice No. / Date"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="Label24" runat="server" Text=":" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblinvoceno" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>--%>
                                                                       <%-- <tr>
                                                                            <td>
                                                                                <asp:Label ID="Label26" runat="server" Font-Bold="True" Text="DC No. / Date "></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="Label27" runat="server" Text=":" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lbldcno" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>--%>
                                                                        <tr >
                                                                            <td  class="hide" >
                                                                                <asp:Label ID="Label25" runat="server" Font-Bold="True" Text="SIGN  " meta:resourcekey="Label25Resource"></asp:Label>
                                                                            </td>
                                                                            <td  class="hide" >
                                                                                <asp:Label ID="Label28" runat="server" meta:resourcekey="Label28Resource1"/>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="a-center v-top" >
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Label29" runat="server" Font-Bold="True" Text="BOOKED BY " meta:resourcekey="Label29Resource"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="Label30" runat="server" Text=":" meta:resourcekey="Label30Resource1"/>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblBooked" runat="server" meta:resourcekey="lblBookedResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Label32" runat="server" Font-Bold="True" Text="REMARKS " meta:resourcekey="Label32Resource"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="Label33" runat="server" Text=":"  meta:resourcekey="Label33Resource1" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblRemarks" runat="server" meta:resourcekey="lblRemarksResource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="a-left hide v-top" >
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Label31" runat="server" Font-Bold="True" Text="FOR " meta:resourcekey="Label31Resource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="Label34" runat="server" Text=":" meta:resourcekey="Label34Resource1" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="Label35" runat="server" meta:resourcekey="Label35Resource1"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </center>
                                    </td>
                                </tr>
                                <tr class="a-center" >
                                    <td  >
                                        <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                            runat="server" CssClass="btn w-40" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource"/>
                               
                                                <asp:Button ID="btnCancel" Text="Cancel Order" runat="server" onmouseover="this.className='btn btnhov'"
                                                    CssClass="btn" onmouseout="this.className='btn'"  Visible="false"
                                            onclick="btnCancel_Click"  meta:resourcekey="btnCancelResource"  />
                                            </td>
                                </tr>
                            </table>
                        </div>
                    </div>    
    <Attune:Attunefooter ID="Attunefooter" runat="server" />          
    </form>
</body>
</html>
