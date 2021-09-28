<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewPurchaseOrder.aspx.cs"
    Inherits="PurchaseOrder_ViewPurchaseOrder" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Purchase Order</title>

    

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        
            <table class="w-100p" >
                <tr>
                    <td>
                        <div id="Divpo" runat="server">
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center"  colspan="3">
                                        <asp:Label ID="lblPurchaseOrder" runat="server" CssClass="bold" Text="Purchase Order"
                                            meta:resourcekey="lblPurchaseOrderResource1"></asp:Label>
                                    </td>
                                </tr>
                            <tr>
                                <td class="a-center" colspan="3">
                                    <asp:Image ID="imgBillLogo" runat="server" />
                                    <br />
                                </td>
                            </tr>
                                <tr class="a-left">
                                    <td colspan="3" class="bold">
                                        <strong>
                                            <asp:Label ID="lblFrom" runat="server" Text="From" meta:resourcekey="lblFromResource1"></asp:Label>                                            
                                        </strong>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td colspan="2" class="w-80p"  >
                                        <div class="marginL10">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblOrgName" CssClass="bold" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblStreetAddress" runat="server" meta:resourcekey="lblStreetAddressResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCity" runat="server" meta:resourcekey="lblCityResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <asp:Label ID="lblPhone" runat="server" meta:resourcekey="lblPhoneResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>                                                      
														 <asp:Label ID="lblTINNo" runat="server" CssClass="bold"  Text="GSTINNo" meta:resourcekey="lblTINNoResource1"></asp:Label>  
                                                        <asp:Label ID="lblOrgTINNo" runat="server" meta:resourcekey="lblOrgTINNoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                       
														
														<asp:Label ID="lblDLNo" CssClass="bold" runat="server" Text="DLNo" meta:resourcekey="lblDLNoResource1"></asp:Label>  
														
                                                        <asp:Label ID="lblOrgDLNo" CssClass="bold" runat="server" meta:resourcekey="lblOrgDLNoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td valign="top" class="w-20p">
                                        <strong>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblDate" CssClass="bold" runat="server" Text="Date" meta:resourcekey="lblDateResource1"></asp:Label>                                                        
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPODate" CssClass="bold" runat="server" meta:resourcekey="lblPODateResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblPONo" runat="server" CssClass="bold" Text="PO No" meta:resourcekey="lblPONoResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPOID" runat="server" meta:resourcekey="lblPOIDResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblStatus1" runat="server" CssClass="bold" Text="Status" meta:resourcekey="lblStatus1Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </strong>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td colspan="3">
                                        <strong>
                                            <asp:Label ID="lblTo" runat="server" Text="To" meta:resourcekey="lblToResource1"></asp:Label>                                            
                                        </strong>
                                    </td>
                                </tr>
                                <tr class="a-left">
                                    <td colspan="3">
                                        <div class="marginL10">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblVendorContactPerson" runat="server" CssClass="bold" meta:resourcekey="lblVendorContactPersonResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblVendorName" runat="server" meta:resourcekey="lblVendorNameResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        
														<asp:Label ID="lblTINNo1" runat="server" CssClass="bold" Text="GSTINNo" meta:resourcekey="lblTINNo1Resource1"></asp:Label>    
                                                        <asp:Label ID="lblVendorTINNo" runat="server" meta:resourcekey="lblVendorTINNoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblVendorAddress" runat="server" meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblVendorCity" runat="server" meta:resourcekey="lblVendorCityResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblVendorEmail" runat="server" meta:resourcekey="lblVendorEmailResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr><td colspan="3"> </td></tr>                               
                                <tr class="a-left">
                                    <td colspan="3">
                                        <div class="marginL10">
                                            <asp:Table CssClass="w-100p gridView" runat="server" ID="purchaseOrderDetailsTab" meta:resourcekey="purchaseOrderDetailsTabResource1">
                                            </asp:Table>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="a-left" >
                                    <td colspan="3" id="commentsTD" runat="server">
                                       
                                    </td>
                                </tr>
                                <tr class="a-left hide" runat="server" id="trShowBankDetails" >
                                    <td colspan="3">
                                        <table class="w-100p">
                                            <tr class="lh30">
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Bank Details :" CssClass="bold"></asp:Label><br />
                                                    <asp:Label id="ShowBankDetails" runat="server"></asp:Label>
                                                </td>
                                             </tr>
                                         </table>
                                    </td>
                                </tr>
                                   <tr class="a-left">
                                    <td colspan="3">
                                     <table class="w-100P hide" id="tblTermsconditions" runat="server">
                                      <tr class="lh20">
                                       <td> 
                                       <asp:Label ID="lblTermsconditions01" runat="server" Text="Terms And Conditions :" CssClass="bold" meta:resourcekey="lblTermsconditions01Resource1"></asp:Label>
                                       </td>
                                      </tr>
                                      
                                      <tr class="lh20">
                                      <td>
                                      <asp:Label ID="lblTermsconditions" runat="server" Text="" meta:resourcekey="lblTermsconditionsResource1"></asp:Label>
                                      </td>
                                      </tr>
                                     </table>

                                    </td>
                                </tr>
                                <tr id="approvalTR" class="a-left hide" runat="server" >
                                <td colspan="5" class="w-90p">
                                <table class="w-100p">
                                            <tr class="lh30">
                                                <td class="bold" nowrap="nowrap">
                                                    <asp:Label ID="lblPreparedDate" runat="server" Text="Prepared Date" ></asp:Label>                                                   
                                                </td>
                                                <td>:</td>
                                                <td id="preparedDateTD" class="w-80p a-left" runat="server">
                                                </td>
                                            </tr>
                                            <tr class="lh10">
                                                <td class="bold">                                                  
                                                    <asp:Label ID="lblPreparedBy" runat="server" Text="Prepared By" ></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td id="preparedByTD" runat="server">
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                                    <td align=right class="w-60p">
                                        <table class="w-100p">
                                            <tr class="lh30">
                                                <td class="bold" nowrap="nowrap">
                                                    <asp:Label ID="lblApprovedDate" runat="server" Text="Approved Date" meta:resourcekey="lblApprovedDateResource1"></asp:Label>                                                   
                                                </td>
                                                <td>:</td>
                                                <td id="approvedDateTD" class="w-80p a-left" runat="server">
                                                </td>
                                            </tr>
                                            <tr class="lh10">
                                                <td class="bold">                                                  
                                                    <asp:Label ID="lblApprovedBy" runat="server" Text="Approved By" meta:resourcekey="lblApprovedByResource1"></asp:Label>
                                                </td>
                                                <td>:</td>
                                                <td id="approvedByTD" runat="server">
                                                </td>
                                            </tr>
                                        </table>
                                      
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table class="w-100p">
                            <tr id="trApproveBlock" class="hide" runat="server">
                                <td colspan="3">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-center">
                                                <input type="hidden" id="hdnApprovePO" runat="server" />
                                                <asp:Button ID="btnEdit" Text="Edit" runat="server" onmouseover="this.className='btn btnhov'"
                                                    CssClass="btn" onmouseout="this.className='btn'" OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" />
                                                <asp:Button ID="btnApprove" Text="Approve" runat="server" onmouseover="this.className='btn btnhov'"
                                                    CssClass="btn" onmouseout="this.className='btn'" OnClick="btnApprove_Click" meta:resourcekey="btnApproveResource1" />
                                                <asp:Button ID="btnPrint1" Text="Print" OnClientClick="CallPrint();return false;"
                                                    Width="40px" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" meta:resourcekey="btnPrint1Resource1" />
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr >
                                <td colspan="3">
                                    <table id="tprint" runat="server" class="w-100p a-center">
                                        <tr>
                                            <td class="a-center">
                                                <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="cancel-btn"
                                                    OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                            
                                                <asp:Button ID="btnPint1" Text="Print" OnClientClick="CallPrint();return false;"
                                                    runat="server" CssClass="btn " meta:resourcekey="btnPint1Resource1" />
                                            </td>
                                            <td id="canOrder" runat="server" >
                                                <asp:Button ID="btnCancel" Text="Cancel Order" runat="server" 
                                                    CssClass="cancel-btn"  OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
       
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>

</html>
<script language="javascript" type="text/javascript">
    //-------------Mani--------
    /*$(document).ready(function() {
        if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'ViewPurchaseOrder') {
            $("#Attuneheader_TopHeader1_lblvalue").text("View Purchase Order");
        }
    });*/
    //----------End------------
    function CallPrint() {
        var prtContent = document.getElementById('Divpo');
        //document.getElementById('btnPint1').style.display = 'none';
        $('#btnPint1').removeClass().addClass('hide');
        //document.getElementById('btnBack').style.display = 'none';
        $('#btnBack').removeClass().addClass('hide');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
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
        $('#btnPint1').removeClass().addClass('btn');
        //document.getElementById('btnBack').style.display = 'none';
        $('#btnBack').removeClass().addClass('cancel-btn');
       // document.getElementById('approvalTR').style.display = 'block';
    }
    </script>