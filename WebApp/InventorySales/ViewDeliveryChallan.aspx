<%@ Page EnableEventValidation="True"  Language="C#" AutoEventWireup="true" CodeFile="ViewDeliveryChallan.aspx.cs" Inherits="InventorySales_ViewDeliveryChallan" meta:resourcekey="PageResource1"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Delivery Challan</title>

    <script src="../PlatForm/Scripts/Common.js" type="text/javascript"></script>

     <script language="javascript" type="text/javascript">

         function CallPrint() {
             //document.getElementById('btnPrint').style.display = "none";
             $('#btnPrint').removeClass().addClass('hide');
             var prtContent = document.getElementById('divDC');
             var WinPrint = window.open('', '', 'letf=0,top=0,right=0,toolbar=0,scrollbars=0,status=0');
             WinPrint.document.write(prtContent.innerHTML);
             WinPrint.document.close();
             WinPrint.focus();
             WinPrint.print();
             WinPrint.close();
             //document.getElementById('btnPrint').style.display = "block";
             $('#btnPrint').removeClass().addClass('show');
         }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
                      
                        <div id="divchellanEStoSupplier">
                            <table class="w-100p custcellpadding2 custcellspacing1 custfontfamily1 custfontsize1">
                                <tr>
                                    <td>
                                        <div id="divDC">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-center style4"  colspan="3" >
                                                    <strong>Delivery Challan</strong>
                                                </td>
                                            </tr>
                                            <tr>
                                                <%-- Header Left Hand Side--%>
                                                <td class="w-70p" >
                                                    <div class="marginL10">
                                                        <table >
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Text="Company Name"  meta:resourcekey="Label6Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label10" runat="server" Text=":" meta:resourcekey="Label10Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblOrgDL" runat="server" Font-Bold="True" Text="Address :" meta:resourcekey="lblOrgDLResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label12" runat="server" Text=":" meta:resourcekey="Label12Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbladdr1" runat="server" meta:resourcekey="lbladdr1Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3" class="style2">
                                                                    <div class="marginL150">
                                                                        <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3">
                                                                    <div class="marginL200" >
                                                                    
                                                                        <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="hide">
                                                                <td>
                                                                    <asp:Label ID="Label13" runat="server" Font-Bold="True" Text="State" meta:resourcekey="Label13Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label15" runat="server" Text=":" meta:resourcekey="Label15Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblState" runat="server" meta:resourcekey="lblStateResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr class="hide" > 
                                                                <td>
                                                                    <asp:Label ID="Label19" runat="server" Font-Bold="True" Text="Country" meta:resourcekey="Label19Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label20" runat="server" Text=":" meta:resourcekey="Label20Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCountry" runat="server" meta:resourcekey="lblCountryResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label21" runat="server" Font-Bold="True" Text="Tel No" meta:resourcekey="Label21Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label22" runat="server" Text=":" meta:resourcekey="Label22Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbltelno" runat="server" meta:resourcekey="lbltelnoResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label9" runat="server" Font-Bold="True" Text="Fax" meta:resourcekey="Label9Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label14" runat="server" Text=":" meta:resourcekey="Label14Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblFax" runat="server" meta:resourcekey="lblFaxResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label23" runat="server" Font-Bold="True" Text="CST No" meta:resourcekey="Label23Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label24" runat="server" Text=":" meta:resourcekey="Label24Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbcsts" runat="server" meta:resourcekey="lbcstsResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label16" runat="server" Font-Bold="True" Text="VAT / Tin No"  meta:resourcekey="Label16Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label17" runat="server" Text=":" meta:resourcekey="Label17Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbltinno" runat="server" meta:resourcekey="lbltinnoResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label36" runat="server" Font-Bold="True" Text="DrugLicenseNo. 1" meta:resourcekey="Label36Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label37" runat="server" Text=":" meta:resourcekey="Label37Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbldruglicenseno1" runat="server" meta:resourcekey="lbldruglicenseno1Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label25" runat="server" Font-Bold="True" Text="DrugLicenseNo. 2" meta:resourcekey="Label25Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label26" runat="server" Text=":" meta:resourcekey="Label26Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbldruglicenseno2" runat="server" meta:resourcekey="lbldruglicenseno2Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label46" runat="server" Font-Bold="True" Text="Pan No." meta:resourcekey="Label46Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label47" runat="server" Text=":" meta:resourcekey="Label47Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbloanno" runat="server" meta:resourcekey="lbloannoResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <%-- ENd  Header Left Hand Side--%>
                                                <%-- Header Right Hand Side--%>
                                                <td >
                                                    <table class="w-30p" >
                                                        <tr class="hide"  >
                                                            <td colspan="3" class="a-center bold"  >
                                                             <asp:Label ID="Label93" runat="server" Text="Tax Invoice" Font-Bold="True"  meta:resourcekey="Label93Resource1" />
                                                                
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                <asp:Label ID="Label76" runat="server" Text="SalesOrder No" Font-Bold="True" meta:resourcekey="Label76Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label83" runat="server" Text=":" meta:resourcekey="Label83Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblsaleOrderNo" runat="server" meta:resourcekey="lblsaleOrderNoResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                  
                                                    
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblorderdate" runat="server" Text="Invoice No" Font-Bold="True" meta:resourcekey="lblorderdateResource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label1" runat="server" Text=":" meta:resourcekey="Label1Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblInvoiceno" runat="server" meta:resourcekey="lblInvoicenoResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                  
                                                        <tr  >
                                                            <td>
                                                                <asp:Label ID="Label2" runat="server" Text="Invoice Date" Font-Bold="True" meta:resourcekey="Label2Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label3" runat="server" Text=":" meta:resourcekey="Label3Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblinvoiceda" runat="server" meta:resourcekey="lblinvoicedaResource1" ></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr >
                                                            <td>
                                                                <asp:Label ID="Label4" runat="server" Text="ChallanNo." Font-Bold="True" meta:resourcekey="Label4Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label5" runat="server" Text=":" meta:resourcekey="Label5Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblchellan" runat="server" meta:resourcekey="lblchellanResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label7" runat="server" Text="ChallanDate" Font-Bold="True"  meta:resourcekey="Label7Resource1"  />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label8" runat="server" Text=":" meta:resourcekey="Label8Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblchellandate" runat="server" meta:resourcekey="lblchellandateResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label11" runat="server" Text="TransportName" Font-Bold="True" meta:resourcekey="Label11Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label18" runat="server" Text=":" 
                                                                    meta:resourcekey="Label18Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lbltransportno" runat="server" meta:resourcekey="Label18Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label27" runat="server" Text="ConsignmentNo" Font-Bold="True" 
                                                                    meta:resourcekey="Label27Resource1"  />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label28" runat="server" Text=":" meta:resourcekey="Label27Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblConsignmentNo" runat="server" meta:resourcekey="lblConsignmentNoResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label29" runat="server" Text="ConsignmentDate" Font-Bold="True"  meta:resourcekey="Label29Resource1"  />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label30" runat="server" Text=":" meta:resourcekey="Label30Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblconsigndate" runat="server" meta:resourcekey="lblconsigndateResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label31" runat="server" Text="ModeOfTransport" Font-Bold="True" meta:resourcekey="Label31Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label32" runat="server" Text=":" meta:resourcekey="Label32Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblmodeoftrans" runat="server"  meta:resourcekey="lblmodeoftransResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="hide">
                                                            <td>
                                                                <asp:Label ID="Label33" runat="server" Text="RoadPermitNo" Font-Bold="True"  meta:resourcekey="Label33Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label34" runat="server" Text=":"  meta:resourcekey="Label34Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPermitno" runat="server" meta:resourcekey="lblPermitnoResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label35" runat="server" Text="PurchaseOrderNo" Font-Bold="True" meta:resourcekey="Label35Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label38" runat="server" Text=":" meta:resourcekey="Label38Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label39" runat="server" meta:resourcekey="Label39Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label40" runat="server" Text="PurchaseOrderDate" Font-Bold="True" meta:resourcekey="Label40Resource1"  />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label41" runat="server" Text=":"  meta:resourcekey="Label41Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblporderdate" runat="server" meta:resourcekey="lblporderdateResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label42" runat="server" Text="Currency" Font-Bold="True" meta:resourcekey="Label42Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label43" runat="server" Text=":" meta:resourcekey="Label43Resource1"/>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblcurrency" runat="server" meta:resourcekey="lblcurrencyResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr  class="hide">
                                                            <td>
                                                                <asp:Label ID="Label44" runat="server" Text="PaymentTerm" Font-Bold="True" meta:resourcekey="Label44Resource1"  />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label45" runat="server" Text=":"  meta:resourcekey="Label45Resource1" />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblpaymentterm" runat="server" meta:resourcekey="lblpaymenttermResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                      
                                                    </table>
                                                </td>
                                                <%-- END Header Right Hand Side--%>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-70p"  >
                                                    <div class="marginL10">
                                                        <table>
                                                            <tr>
                                                                <td >
                                                                    <asp:Label ID="Label79" runat="server" Font-Bold="True" Text="CustomerName & Address" meta:resourcekey="Label79Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label48" runat="server" Font-Bold="True" Text="Name" meta:resourcekey="Label48Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label49" runat="server" Text=":" meta:resourcekey="Label49Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblnames" runat="server" meta:resourcekey="lblnamesResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label51" runat="server" Font-Bold="True" Text="Address :"  meta:resourcekey="Label51Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label52" runat="server" Text=":" meta:resourcekey="Label52Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbladdrs" runat="server" meta:resourcekey="lbladdrsResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3" class="style2">
                                                                    <div class="marginL150">
                                                                        <asp:Label ID="lbladdress2" runat="server" meta:resourcekey="lbladdress2Resource1"></asp:Label>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr > 
                                                                <td colspan="3">
                                                                    <div class="marginL150">
                                                                        <asp:Label ID="lblcities" runat="server" meta:resourcekey="lblcitiesResource1"></asp:Label>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr class="hide">
                                                                <td>
                                                                    <asp:Label ID="Label56" runat="server" Font-Bold="True" Text="State" meta:resourcekey="Label56Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label57" runat="server" Text=":" meta:resourcekey="Label57Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblstates" runat="server" meta:resourcekey="lblstatesResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr class="hide">
                                                                <td>
                                                                    <asp:Label ID="Label59" runat="server" Font-Bold="True" Text="Country" meta:resourcekey="Label59Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label60" runat="server" Text=":" meta:resourcekey="Label60Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblcountries" runat="server"  meta:resourcekey="lblcountriesResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label62" runat="server" Font-Bold="True" Text="Tel No" meta:resourcekey="Label62Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label63" runat="server" Text=":" meta:resourcekey="Label63Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbltelephones" runat="server" meta:resourcekey="lbltelephonesResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label65" runat="server" Font-Bold="True" Text="Fax" meta:resourcekey="Label65Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label66" runat="server" Text=":" meta:resourcekey="Label66Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblfaxes" runat="server" meta:resourcekey="lblfaxesResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label68" runat="server" Font-Bold="True" Text="CST No" meta:resourcekey="Label68Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label69" runat="server" Text=":"  meta:resourcekey="Label69Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblcst" runat="server" meta:resourcekey="lblcstResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label71" runat="server" Font-Bold="True" Text="VAT / Tin No" meta:resourcekey="Label71Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label72" runat="server" Text=":" meta:resourcekey="Label72Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblsvat" runat="server" meta:resourcekey="lblsvatResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label74" runat="server" Font-Bold="True" Text="DrugLicenseNo. 1" meta:resourcekey="Label74Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label75" runat="server" Text=":" meta:resourcekey="Label75Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="drupnos" runat="server" meta:resourcekey="drupnosResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label77" runat="server" Font-Bold="True" Text="DrugLicenseNo. 2" meta:resourcekey="Label77Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label78" runat="server" Text=":" meta:resourcekey="Label78Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbsdrugsno2" runat="server" meta:resourcekey="lbsdrugsno2Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label80" runat="server" Font-Bold="True" Text="Territory"  meta:resourcekey="Label80Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label81" runat="server" Text=":" meta:resourcekey="Label81Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblterritory" runat="server"  meta:resourcekey="lblterritoryResource1"></asp:Label>
                                                                    
                                                   
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td class="v-top w-30p">
                                                    <div>
                                                        <table>
                                                            <tr>
                                                                <td colspan="3">
                                                                    <asp:Label ID="Label82" runat="server" Font-Bold="True" Text="Ship To Name & Address" meta:resourcekey="Label82Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                             <tr  >
                                                                <td>
                                                                    <asp:Label ID="Label54" runat="server" Font-Bold="True" Text="Name" meta:resourcekey="Label54Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label61" runat="server" Text=":" meta:resourcekey="Label61Resource1"/>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCustomerLocName" runat="server" 
                                                                        meta:resourcekey="lblCustomerLocNameResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr  >
                                                                <td>
                                                                    <asp:Label ID="Label50" runat="server" Font-Bold="True" Text="LocationName" meta:resourcekey="Label50Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label53" runat="server" Text=":" 
                                                                        meta:resourcekey="Label53Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCustomerName" runat="server" 
                                                                        meta:resourcekey="lblCustomerNameResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr >
                                                                <td>
                                                                    <asp:Label ID="Label55" runat="server" Font-Bold="True" Text="Address " meta:resourcekey="Label55Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label58" runat="server" Text=":" 
                                                                        meta:resourcekey="Label58Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCustomerLocAddress" runat="server" 
                                                                        meta:resourcekey="lblCustomerLocAddressResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr  class="hide">
                                                                <td colspan="3" class="style2">
                                                                    <div class="marginL150">
                                                                        <asp:Label ID="Label64" runat="server" meta:resourcekey="Label64Resource1"></asp:Label>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr  class="hide">
                                                                <td colspan="3">
                                                                    <div class="marginL150">
                                                                        <asp:Label ID="Label67" runat="server" meta:resourcekey="Label67Resource1"></asp:Label>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr  class="hide">
                                                                <td>
                                                                    <asp:Label ID="Label70" runat="server" Font-Bold="True" Text="State" meta:resourcekey="Label70Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label73" runat="server" Text=":" 
                                                                        meta:resourcekey="Label73Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCustomerState" runat="server" 
                                                                        meta:resourcekey="lblCustomerStateResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr >
                                                                <td>
                                                                    <asp:Label ID="Label84" runat="server" Font-Bold="True" Text="Tel No" meta:resourcekey="Label84Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label85" runat="server" Text=":" 
                                                                        meta:resourcekey="Label85Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCustomerTelNo" runat="server" 
                                                                        meta:resourcekey="lblCustomerTelNoResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr >
                                                                <td>
                                                                    <asp:Label ID="Label87" runat="server" Font-Bold="True" Text="Fax No" meta:resourcekey="Label87Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label88" runat="server" Text=":" meta:resourcekey="Label88Resource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLocationFax" runat="server" 
                                                                        meta:resourcekey="lblLocationFaxResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:GridView EmptyDataText="No matching records found " ID="grdResult"
                                                        runat="server" AutoGenerateColumns="False" ForeColor="#333333" CssClass="w-100p custcellspacing1"
                                                                        onrowdatabound="grdResult_RowDataBound" 
                                                        meta:resourcekey="grdResultResource1">
                                                       <Columns>
                                                            <asp:TemplateField HeaderText="SL No." meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <%#Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Material Description" DataField="Description"  meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField HeaderText="Batch No" DataField="BatchNo" meta:resourcekey="BoundFieldResource2"/>
                                                              <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                        <span>
                                                            <%#((DateTime)DataBinder.Eval(Container.DataItem, "Manufacture")).ToString(DateTimeFormat)%>
                                                        </span>
                                                        <span>
                                                            <%#((DateTime)DataBinder.Eval(Container.DataItem, "ExpiryDate")).ToString(DateTimeFormat)%>
                                                        </span>
                                                       <%-- MFT :
                                                        <%# Eval("Manufacture", "{0:MMM/yyyy}").ToString() == "Jan/1753" ? ("**") :Eval("Manufacture", "{0:dd/MM/yyyy}")%><br />
                                                        EXP :
                                                        <%# Eval("ExpiryDate", "{0:MMM/yyyy}").ToString() == "Jan/1753" ? ("**") : Eval("ExpiryDate", "{0:dd/MM/yyyy}")%>--%>
                                                    </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:BoundField HeaderText="MFTCode" DataField="ProductKey" meta:resourcekey="BoundFieldResource3"/>
                                                               <asp:BoundField HeaderText="Quantity" DataField="Quantity" meta:resourcekey="BoundFieldResource4"/>
                                                           <asp:BoundField HeaderText="UOM" DataField="Unit" meta:resourcekey="BoundFieldResource5"/>
                                                           <asp:BoundField HeaderText="Rate" DataField="UnitPrice" Visible="false" meta:resourcekey="BoundFieldResource6"/>
                                                            <asp:TemplateField HeaderText="Rate" meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                  <%#(Convert.ToDecimal( Eval("UnitPrice")).ToString("0.00"))%>
                                                                  
                                                                    
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            
                                                                <asp:TemplateField HeaderText="Value" meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                  <%#(Convert.ToDecimal( Eval("UnitPrice"))*Convert.ToDecimal(Eval("Quantity"))).ToString("0.00")%>
                                                                                                                                      
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                         
                                                              <asp:BoundField HeaderText="Discount(%)" DataField="Discount" meta:resourcekey="BoundFieldResource7"/>
                                                             <%--   <asp:BoundField HeaderText="Discount Value" DataField="Discountvalue" />--%>
                                                              
                                                           <asp:TemplateField HeaderText="Discount Value" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                  <%#((Convert.ToDecimal(Eval("Discount")) *Convert.ToDecimal(Eval("Quantity")) *Convert.ToDecimal(Eval("UnitPrice"))) / Convert.ToDecimal(100)).ToString("0.00")%>
                                                                  
                                                                    
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:BoundField HeaderText="Excise Duty" DataField="ExciesDuty" meta:resourcekey="BoundFieldResource8"/>
                                                            <asp:BoundField HeaderText="VATRate(%)" DataField="TaxPercent" meta:resourcekey="BoundFieldResource9" />
                                                            <asp:BoundField HeaderText="VATValue" DataField="Taxvalues" meta:resourcekey="BoundFieldResource10" />
                                                              <asp:BoundField HeaderText="CSTRate(%)" DataField="CSTax" meta:resourcekey="BoundFieldResource11" />
                                                            <asp:BoundField HeaderText="CSTValue" DataField="CSTAmount" meta:resourcekey="BoundFieldResource12" />
                                                                                                                 
                                                            <asp:BoundField HeaderText="MRP" DataField="MRP"  meta:resourcekey="BoundFieldResource13"/>
                                                            <asp:BoundField HeaderText="MRP Value" DataField="TotalMRP" meta:resourcekey="BoundFieldResource14" />
                                                            <asp:BoundField HeaderText="TotalCost" DataField="TotalCost" meta:resourcekey="BoundFieldResource15"/>
                                                                                                                   
                                                        </Columns> 
                                                    </asp:GridView>
                                                    </td>
                                            </tr>
                                            <tr>
                                                <td class="a-right"  colspan="3">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-right">
                                                                
                                                                <asp:Label ID="lblTotalValue" runat="server" Text="Total Value :" meta:resourcekey="lblTotalValueResource1" />
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblTotalSales" CssClass="w-50" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblTotalSalesResource1"></asp:Label>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right">
                                                                
                                                                <asp:Label ID="lblLessDiscount" runat="server" Text="Less: Discount :" meta:resourcekey="lblLessDiscountResource1" />
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbldiscount1" CssClass="w-50" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbldiscount1Resource1"></asp:Label>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right">
                                                                
                                                                <asp:Label ID="lblAddVatTax" runat="server" Text="Add: VAT/Tax (as Applicable) :" meta:resourcekey="lblAddVatTaxResource1" />
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblvatcst" CssClass="w-51 h-16" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblvatcstResource1"></asp:Label>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr id="lbltotalExe" runat="server">
                                                            <td class="a-right">
                                                                
                                                                <asp:Label ID="lblAddCST" runat="server" Text="Add: Addtl.CST (as Applicable) :" meta:resourcekey="lblAddCSTResource1" />
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbladdlvat" CssClass="w-50" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbladdlvatResource1"></asp:Label>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr id="trCess2" runat="server">
                                                            <td class="a-right">
                                                                
                                                                <asp:Label ID="lblAddSurcharge" runat="server" Text="Add:Surcharge\cess(if Applicable):" meta:resourcekey="lblAddSurchargeResource1" />
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lblsurcharge" CssClass="w-50" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblsurchargeResource1"></asp:Label>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr id="trEdCess1" runat="server">
                                                            <td class="a-right">
                                                                
                                                                <asp:Label ID="lblLessOctori" runat="server" Text="Less:Octori (if Applicable):" meta:resourcekey="lblLessOctoriResource1" />
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td class="a-right">
                                                                <asp:Label ID="lbloctori" CssClass="w-50" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lbloctoriResource1"></asp:Label>&nbsp;
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                       
                                                            <td class="a-right"> 
                                                            
                                                            <asp:Label ID="lblGrandTotal1" runat="server" Text="Grand Total :" meta:resourcekey="lblGrandTotal1Resource1" />
                                                            &nbsp;&nbsp;
                                                            </td> 
                                                            <td class="a-right">
                                                            <asp:Label ID="lblGrandTotal" CssClass="w-50" runat="server" Text="0.00" 
                                                                    meta:resourcekey="lblGrandTotalResource1"></asp:Label>&nbsp;
                                                            
                                                            </td>
                                                         </tr>
                                                                                                                                                       
                                                        <tr>
                                                             <td class="a-right">
                                                                
                                                                <asp:Label ID="lblTotal1" runat="server" Text="Total :" meta:resourcekey="lblTotal1Resource1" />
                                                                &nbsp;&nbsp;
                                                                </td> 
                                                                <td class="a-right">
                                                                <asp:Label ID="lblTotal" CssClass="w-50" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblTotalResource1"></asp:Label>&nbsp;
                                                               
                                                            </td>
                                                        </tr>
                                                                             
                                                        <tr>
                                                            <td class="a-right">
                                                                
                                                                <asp:Label ID="lblRoundOffValue1" runat="server" Text="RoundOff Value :" meta:resourcekey="lblRoundOffValue1Resource1" />
                                                                &nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                <asp:Label ID="lblRoundOffValue" CssClass="w-50" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblRoundOffValueResource1"></asp:Label>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                           <td class="a-right">
                                                                
                                                                <asp:Label ID="lblRoundedOffNetTotal1" runat="server" Text="Rounded-Off Net Total :" meta:resourcekey="lblRoundOffNetTotal1Resource1" />
                                                                &nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                <asp:Label ID="lblRoundOffNetTotal" CssClass="w-50" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblRoundOffNetTotalResource1"></asp:Label>&nbsp;
                                                               
                                                            </td>
                                                        </tr>
                                                                            <tr runat="server" id="lblcst5">
                                                                                <td class="a-right">
                                                                                    
                                                                                    <asp:Label ID="lblinvoicevalue1" runat="server" Text="Invoice Value:" meta:resourcekey="lblinvoicevalue1Resource1" />
                                                                                    &nbsp;&nbsp;
                                                                                </td>
                                                                                <td class="a-right">
                                                                                    <asp:Label ID="lblinvoicevalue" CssClass="w-50" runat="server" Text="0.00" 
                                                                                        meta:resourcekey="lblinvoicevalueResource1"></asp:Label>&nbsp;
                                                                                </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblAmtword" runat="server" Font-Bold="True" 
                                                                Text="Amount in Words" Visible="False" meta:resourcekey="lblAmtwordResource1" ></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label90" runat="server" Text=":" Visible="False" 
                                                                meta:resourcekey="Label90Resource1"  />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblAmountWords" runat="server" 
                                                                meta:resourcekey="lblAmountWordsResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblquotes" runat="server" meta:resourcekey="lblquotesResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label92" runat="server" meta:resourcekey="Label92Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </tr>
                                            <tr class="a-center" >
                                            <td>
                                
                                                <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                                runat="server" CssClass="btn w-40" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource1"/>
                                            </td>
                                            
                                            </tr>
                                        </table>
                                        </div> 
                               
      </div>
                    
                    
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
               
    </form>
</body>
</html>
