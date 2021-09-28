<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseOrderQuantity.aspx.cs"
    Inherits="PurchaseOrder_PurchaseOrderQuantity" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Purchaseorder Quantity</title>
      

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGeneratePO">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
     
                    <div class="contentdata">
                       
                        <table class="w-100p">
                            <tr>
                                <td colspan="3">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <table class="w-100p">
                                                <tr>
                                                    <td colspan="2" class="a-left">
                                                        <asp:Label ID="lblSupplierDetails" runat="server" Text="Supplier Details :" meta:resourcekey="lblSupplierDetailsResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                        <asp:DropDownList ID="ddlSupplierList" runat="server" AutoPostBack="True" CssClass="large"
                                                            OnSelectedIndexChanged="ddlSupplierList_SelectedIndexChanged" meta:resourcekey="ddlSupplierListResource1">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hdnSName" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="w-80">
                                                    </td>
                                                    <td class="a-left v-top">
                                                        <div id="divSupplier" runat="server" class="hide">
                                                            <table class="v-top">
                                                                <tr>
                                                                    <td class="a-left">
                                                                        <asp:Label ID="lblAddress" runat="server" Text="Address" meta:resourcekey="lblAddressResource1"></asp:Label>&nbsp;
                                                                        :
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblVendorAddress" Text="--" runat="server" meta:resourcekey="lblVendorAddressResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left">
                                                                        <asp:Label ID="lblCity" runat="server" Text="City" meta:resourcekey="lblCityResource1"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        :
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblVendorCity" runat="server" meta:resourcekey="lblVendorCityResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left">
                                                                        <asp:Label ID="lblPhone" runat="server" Text="Phone" meta:resourcekey="lblPhoneResource1"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        :
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblVendorPhone" runat="server" meta:resourcekey="lblVendorPhoneResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left">
                                                                        <asp:Label ID="lblEmailID1" runat="server" Text=" Email ID :" meta:resourcekey="lblEmailID1Resource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblEmailID" runat="server" meta:resourcekey="lblEmailIDResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                <td colspan="3" class="v-top">
                    <table class="w-100p">
                        <tr>
                            <td class="v-top">
                                <table class="w-100p">
                                    <tr>
                                        <td colspan="2">
                                            <asp:Table CellPadding="4" CssClass="w-100p gridView" runat="server" ID="purchaseOrderDetailsTab"
                                                meta:resourcekey="purchaseOrderDetailsTabResource1">
                                    </asp:Table>
                                    <asp:HiddenField ID="hdnPurchaseOrderItems" runat="server" />
                                    <input type="hidden" id="hdnCollectedItems" runat="server" />
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td>
                                    <span class="marginT15 pull-left">
                                    <%--Arun--%>
                                        <asp:LinkButton class="btn" ID="lnkAddMore" OnClientClick="javascript: return collectValuesForAddMore();"
                                            runat="server"><%=Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_02%></asp:LinkButton></span>
                                            <%--end--%>
                                </td>
                                <td runat="server" class="hide" id="tdPORecd">
                                    <asp:CheckBox ID="ChkIsPODisplay" runat="server" Text="PO Receivable From Other Location"
                                        meta:resourcekey="ChkIsPODisplayResource1" />
                                </td>
                            </tr>
                            <tr id="trApproveBlock" class="hide" runat="server">
                                        <td colspan="2" class="a-center">
                                    
                                    <table class="marginT15 w-100p">
                                        <tr>
                                            <td class="a-left">
                                                <input type="hidden" id="hdnApprovePO" runat="server" />
                                                <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="cancel-btn"
                                                    OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                                <asp:Button ID="btnApprove" Text="Approve PO" runat="server" OnClientClick="javascript:if(!collectValues()) return false;"
                                                    CssClass="btn" onmouseout="this.className='btn'"
                                                    OnClick="btnGeneratePO_Click" meta:resourcekey="btnApproveResource1" />
                                                <asp:Button ID="btnCancelPO" Text="Cancel PO" runat="server" 
                                                    CssClass="cancel-btn" OnClick="btnCancelPO_Click"
                                                    meta:resourcekey="btnCancelPOResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="tprint" class="displaytr" runat="server">
                                        <td colspan="2" class="a-center">
                                    <br />
                                    <asp:Button ID="btnGeneratePO" Text="Finish" runat="server" 
                                        CssClass="btn" OnClientClick="javascript:if(!collectValues()) return false;"
                                        OnClick="btnGeneratePO_Click" meta:resourcekey="btnGeneratePOResource1" />
                                    &nbsp;
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" 
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                            </td>
                            <td class="w-30p v-top">
                                <div id="dvlocationDetailsTab">
                                    <asp:Table CellPadding="3" CssClass="w-100p gridView" runat="server" ID="locationDetailsTab"
                                        meta:resourcekey="locationDetailsTabResource1">
                                    </asp:Table>
                    </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
        <asp:HiddenField ID="hdnPoDate" runat="server" />
        <asp:HiddenField ID="hdnComments" runat="server" />
        <asp:HiddenField ID="hdnTotal" Value="0" runat="server" />
        <asp:HiddenField ID="hdntotalcost" Value="0" runat="server" />
   
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <asp:HiddenField ID="hdnOrgId" runat="server" />
    <asp:HiddenField ID="hdnOrgAddressID" runat="server" />
    <asp:HiddenField ID="hdnLocationId" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
 

        /*Sathish--SupplierList in PurchaseOrderQty*/
        function SupplierList(obj)
        {
        try
        {
        var SupplierList="../InventoryMaster/SupplierList.aspx?pID="+obj+"&sID="+$('#ddlSupplierList').val()+"&IsPopup=Y";
        newwindow=window.open(SupplierList,'Supplier_List','height=450 width=800 scrollbars=yes');
                        // "SupplierList.aspx?pID=" + obj + "&sID=" + document.getElementById('ddlSupplierList').value + "&IsPopup=Y";
        //alert('Ok');
        newwindow.focus();
        return false;
        }
        catch(e)
        {
        alert('Please Contact your Administrator');
        }
        }
        $(document).ready(function() {
        TotalCalc();
        });
    </script>
</body>
<script language="javascript" type="text/javascript">
//     //-------------Mani--------
//     $(document).ready(function() {
//         if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'PurchaseOrderQuantity') {
//             $("#Attuneheader_TopHeader1_lblvalue").text("Purchase Order Quantity");
//         }
//     });
//     //----------End------------
     function checkIsEmpty(id) {
         if (document.getElementById(id).value == '') {
             document.getElementById(id).value = parseFloat(0).toFixed(2);
             ToTargetFormat(($('#' + id)));

         }
         else {
             document.getElementById(id).value = parseFloat(document.getElementById(id).value).toFixed(2);
             ToTargetFormat(($('#' + id)));
         }
            return true;
     }
     function collectValues() {
         var i;
         var q;
         var y;
         var d;
         var u;
         var id;
         var bat;
            var Dis;
            var cost;
            var tax;
            var Tc;
            var Ta;
            var Cq;
            var Pt;
         if (document.getElementById('hdnPurchaseOrderItems').value != "") {
            // var x = document.getElementById('hdnPurchaseOrderItems').value.split("^");
             var x = JSON.parse($('#hdnPurchaseOrderItems').val());
         }
         else {
             return false;
         }
         document.getElementById('hdnCollectedItems').value = '';
         var lstPurchaselst = [];
         // for (i = 0; i < x.length; i++) {
         var lblFlag = true;
         $.each(x, function(obj, value) {
             var val;
             if (lblFlag == true) {
                 //if (x[i] != "") {
                 /*y = x[i].split("~");
                 q = "Q" + y[0];
                 u = "U" + y[0];
                 d = "INH" + y[0];
                 id = "ID" + y[0];
                 bat = "BAT" + y[0]; */
                 q = "Q" + value.ProductID;
                 u = "U" + value.ProductID;
                 d = "INH" + value.ProductID;
                 id = "ID" + value.ProductID;
                 bat = "BAT" + value.ProductID;
                 Dis = "DIS" + value.ProductID;
                 cost = "C" + value.ProductID;
                 tax = "T" + value.ProductID;
                  Tc="TC" + value.ProductID;
                    Ta = "TA" + value.ProductID;
                    Cq = "CQ" + value.ProductID;
                    Pt="PT" + value.ProductID;
                 if (document.getElementById(id) == null) {
                     val = 0
                 }
                 else {
                     val = document.getElementById(id).value
                 }

                 var Select = SListForAppDisplay.Get('PurchaseOrder_PurchaseOrderQuantity_aspx_01');
                 if (Select == null) {
                     Select = "--Select--";
                 }
                 if (document.getElementById(u).options[document.getElementById(u).selectedIndex].text == Select
                  || document.getElementById(u).options[document.getElementById(u).selectedIndex].value == "0") {

                     var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_01") == null ? "Select the unit" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_01");
                     //                     var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrderQuantity_aspx_01');
                     //                     var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
                     //                     if (userMsg != null && errorMsg != null) {
                     //                         ValidationWindow(userMsg, errorMsg);
                     //                         return false;
                     //                     }
                     //                     else {
                     ValidationWindow(userMsg, errorMsg);
                     lblFlag = false;
                     // return;
                     // }
                     //end
                     document.getElementById(u).focus();
                     return;
                 }
                 var POQuantity = parseFloat(ToInternalFormat($('#' + q)));
                 if (POQuantity == 0) {
                     document.getElementById(q).focus();

                     var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_03") == null ? "Purchase Ordered Qty Cannot Be Zero" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_03");
                     ValidationWindow(userMsg, errorMsg);
                     //return false;
                     lblFlag = false;
                     return;
                     //end
                 }
                 value.Quantity = POQuantity;
                 value.Unit = document.getElementById(u).options[document.getElementById(u).selectedIndex].text;
               //  value.ID = document.getElementById(id).value;

                 if (value.ID == 0) {

                     value.ID = 0;
                 }
                 else {
                     value.ID = val;
                 }
                 
                 
                 value.ProductID = value.ProductID;
                 //value.ProductID = document.getElementById(id).value;
                // value.CategoryName=document.getElementById(C).value;
                 value.BatchNo=document.getElementById(bat).value;
                 value.Discount=ToInternalFormat($('#'+Dis));//document.getElementById(Dis).value;
                 value.Amount=ToInternalFormat($('#'+cost));//document.getElementById(cost).value;
                 value.Tax=ToInternalFormat($('#'+tax));//document.getElementById(tax).value;
                 value.ComplimentQTY=ToInternalFormat($('#'+Cq));//document.getElementById(Cq).value;
                 value.PurchaseTax=ToInternalFormat($('#'+Pt));//document.getElementById(Pt).value;
                 value.Rate=ToInternalFormat($('#'+Tc));//document.getElementById(Tc).innerText;
                 value.UnitSellingPrice=ToInternalFormat($('#'+Ta));//document.getElementById(Ta).innerText;
                 lstPurchaselst.push(value);
                 //   document.getElementById('hdnCollectedItems').value += y[0] + '~' + y[1] + '~' + y[2] + '~' + POQuantity + '~' + ToInternalFormat($('#' + d)) + '~' + document.getElementById(u).options[document.getElementById(u).selectedIndex].text + '~' + document.getElementById(bat).value + '~' + y[7] + '~' + val + '^';
                 //}
             }
         });
         if (lblFlag == false) {
             return false;
         }
         $('#hdnCollectedItems').val(JSON.stringify(lstPurchaselst));
         
         if (document.getElementById('hdnCollectedItems').value == "") {
             
             var userMsg = SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_02") == null ? "Check that the items added or quantity is provided properly" : SListForAppMsg.Get("PurchaseOrder_PurchaseOrderQuantity_aspx_02");
//             var userMsg = SListForAppMsg.Get('PurchaseOrder_PurchaseOrderQuantity_aspx_02');
//             var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error');
//             if (userMsg != null && errorMsg != null) {
//                 ValidationWindow(userMsg, errorMsg);
//                 return false;
//             }
//             else {
             ValidationWindow(userMsg, errorMsg);
                 return false;
             //}
         }
         document.getElementById('hdnPurchaseOrderItems').value = document.getElementById('hdnCollectedItems').value;
         return true;
//         else {
//             if ( document.getElementById(q).value > 0) {
//             
//                 document.getElementById('btnGeneratePO').style.display = "none";
//                 return true;
//             }
//             else {
//                 document.getElementById(q).focus();
//                 ValidationWindow('Purchase Ordered Qty Cannot Be Zero','Alert');
//                 
//             }
//         }

     }



     function collectValuesForAddMore() {
         var i;
         var q;
         var y;
         var d;
         var u;
         var id;
         var bat;
            var Dis;
            var cost;
            var tax;
            var Tc;
            var Ta;
            var Cq;
            var Pt
         if (document.getElementById('hdnPurchaseOrderItems').value != "") {
             //var x = document.getElementById('hdnPurchaseOrderItems').value.split("^");
             var x = JSON.parse($('#hdnPurchaseOrderItems').val());
         }
         else {
             return false;
         }
         var lstPurchaselst = [];
       //  for (i = 0; i < x.length; i++) {
         $.each(x, function(obj, value) {

             var val = 0;
             //if (x[i] != "") {
             /* y = x[i].split("~");
             q = "Q" + y[0];
             u = "U" + y[0];
             d = "INH" + y[0];
             id = "ID" + y[0];
             bat = "BAT" + y[0];*/
             q = "Q" + value.ProductID;
             u = "U" + value.ProductID;
             d = "INH" + value.ProductID;
             id = "ID" + value.ProductID;
             bat = "BAT" + value.ProductID;
             Dis = "DIS" + value.ProductID;
             cost = "C" + value.ProductID;
             tax = "T" + value.ProductID;
             Tc = "TC" + value.ProductID;
             Ta = "TA" + value.ProductID;
                 
                    Cq = "CQ" +value.ProductID;
                    Pt="PT" +value.ProductID;
                   
                 if (document.getElementById(id) == null) {
                     val = 0
                 }
                 else {
                     val = document.getElementById(id).value
                 }

                                                     /*   ProductID = g.Key.ProductID,
                                                        ProductName = g.Key.ProductName,
                                                        Unit = g.Key.Unit,
                                                        ID = g.Key.ID,
                                                        Quantity = g.Key.Quantity,
                                                        CategoryID = g.Key.CategoryID,
                                                        CategoryName = g.Key.CategoryName,
                                                         Description = Convert.ToString(g.Sum(p => Convert.ToDecimal(p.Description))),
                                                         Discount = g.Key.Discount,
                                                         Amount = g.Key.Amount,
                                                         Tax = g.Key.Tax,
                                                         Rate = g.Key.Rate,
                                                         UnitSellingPrice = g.Key.UnitSellingPrice,
                                                         ComplimentQTY=g.Key.ComplimentQTY,
														 PurchaseTax=g.Key.PurchaseTax*/
             if (value.ID == 0) {

                 value.ID = 0;
             }
             else {
                 value.ID = val;
             }
             value.ProductID = value.ProductID;
             value.Quantity = ToInternalFormat($('#'+q));//document.getElementById(q).value;
             value.Unit = document.getElementById(u).value;
             
             value.Discount = ToInternalFormat($('#'+Dis));//document.getElementById(Dis).value;
             value.Tax =ToInternalFormat($('#'+tax));// document.getElementById(tax).value;
             value.Amount=ToInternalFormat($('#'+cost));//document.getElementById(cost).value;
             value.Rate = ToInternalFormat($('#'+Tc));//document.getElementById(Tc).innerText;
             value.UnitSellingPrice = ToInternalFormat($('#'+Ta));//document.getElementById(Ta).innerText;
             
            // value.Amount = document.getElementById(u).value;
            
             //value.Amount = document.getElementById(u).value;
             //value.Tax = document.getElementById(u).value;
             value.ComplimentQTY =ToInternalFormat($('#'+Cq));// document.getElementById(Cq).value;
             value.PurchaseTax=ToInternalFormat($('#'+Pt));//document.getElementById(Pt).value;
             // document.getElementById('hdnCollectedItems').value += y[0] + '~' + y[1] + '~' + y[2] + '~' + document.getElementById(q).value + '~' + document.getElementById(d).value + '~' + document.getElementById(u).options[document.getElementById(u).selectedIndex].text + '~' + document.getElementById(bat).value + '~' + y[7] + '~' + val + '^';

             // }
             lstPurchaselst.push(value);
         });

         $('#hdnCollectedItems').val(JSON.stringify(lstPurchaselst));
         
         document.getElementById('hdnPurchaseOrderItems').value = document.getElementById('hdnCollectedItems').value;
     }
          function TotalCalc() {
            
            var i;
            var u;
            var cost;
            var tax;
            var Dis;
            var Tc;
            var Ta;
            var Pt;
            var q;
            var Totalcost;
            var Totalamount;
            var Tax2;
            var Discount;
            var Unit;
            var Price;
            var Tax1;
            var Disc, Total,Discount1;
            var PurchaseTax;
            Total = 0.00;
			 var x = JSON.parse($('#hdnPurchaseOrderItems').val());
            if (document.getElementById('hdnPurchaseOrderItems').value != "") {
             //   var x = document.getElementById('hdnPurchaseOrderItems').value.split("^");
              //  for (i = 0; i < x.length; i++) {
                //    if (x[i] != "") {
				 $.each(x, function(obj, value) {
        
                        /*y = x[i].split("~");
                        q = "Q" + y[0];
                        cost = "C" + y[0];
                        tax = "T" + y[0];
                        Dis = "DIS" + y[0];
                        Tc = "TC" + y[0];
                        Ta = "TA" + y[0];
                        Pt="PT"+y[0];*/
						q = "Q" + value.ProductID;
                        cost = "C" +value.ProductID;
                        tax = "T" + value.ProductID;
                        Dis = "DIS" +value.ProductID;
                        Tc = "TC" + value.ProductID;
                        Ta = "TA" + value.ProductID;
                        Pt="PT"+ value.ProductID;
						//Unit = Number(ToInternalFormat($('#'+q)));
                        //Price = Number(ToInternalFormat($('#'+cost))); //Number(document.getElementById(cost).value);
                      
						Totalamount = Number(ToInternalFormat($('#'+Ta)));//document.getElementById(Ta).value;
                        /*Unit = Number(document.getElementById(q).value);
                        Price = Number(document.getElementById(cost).value);
                        Tax1 = Number(document.getElementById(tax).value);
                        Disc = Number(document.getElementById(Dis).value);
                        PurchaseTax=Number(document.getElementById(Pt).value);*/
						Unit = Number(ToInternalFormat($('#'+q)));
                        Price = Number(ToInternalFormat($('#'+cost)));
                        Tax1 = Number(ToInternalFormat($('#'+tax)));
                        Disc = Number(ToInternalFormat($('#'+Dis)));
                        PurchaseTax=Number(ToInternalFormat($('#'+Pt)));
						
                        Totalcost = (Unit * Price);
                        Discount = ((Totalcost * Disc) / 100);
                        Discount1 = Totalcost - Discount;
                        if(PurchaseTax!=undefined)/* not = eqa*/
                        {
                        Tax2 = ((Discount1 * PurchaseTax)) / 100;
                        }
                        else
                        {
                        
                        Tax2 = 0;//((Discount1 * Tax1)) / 100;
                      }
                        Totalamount = Discount1 + Tax2;
                        document.getElementById(Tc).innerHTML = parseFloat(Totalcost).toFixed(2);
                        document.getElementById(Ta).innerHTML = parseFloat(Totalamount).toFixed(2);
                        Total = Number(Total)+Number(Totalamount);
                        document.getElementById('lblTotal').innerHTML ="Total value:" +parseFloat(Total).toFixed(2);
						ToTargetFormat($('#'+Tc));
						ToTargetFormat($('#'+Ta));
                   // }
                //}
				});
            }
            else {
                return false;
            }
             document.getElementById('hdntotalcost').value = Tc;
            return true;
        }
        function Calc() 
        {
            var i;
            var u;
            var cost;
            var Tc;
            var Unit;
            var Price;
            var total;
			var x = JSON.parse($('#hdnPurchaseOrderItems').val());
            if (document.getElementById('hdnPurchaseOrderItems').value != "") 
            {
               // var x = document.getElementById('hdnPurchaseOrderItems').value.split("^");
               // for (i = 0; i < x.length; i++) {
                   // if (x[i] != "") {
				   $.each(x, function(obj, value) {
                        /*y = x[i].split("~");
                        q = "Q" + y[0];
                        cost = "C" + y[0];
                        Tc = "TC" + +y[0];*/
						 q = "Q" + value.ProductID;
                        cost = "C" + value.ProductID;
                        Tc = "TC" + value.ProductID;
						//ToInternalFormat($('#
                        //Unit = Number(  document.getElementById(q).value);
                        //Price = Number(document.getElementById(cost).value);
						Unit = Number(ToInternalFormat($('#'+q)));
                        Price = Number(ToInternalFormat($('#'+cost))); //Number(document.getElementById(cost).value);
                        total = Unit * Price;
                        document.getElementById(Tc).innerHTML = parseFloat(total).toFixed(2);
						ToTargetFormat($('#'+Tc));
                   // }
                //}
				});
            }
            else {
                return false;
            }
             
            //Tc = total;
            document.getElementById('hdntotalcost').value = total;
            
            return true;

        }
    </script>

<script type="text/javascript">
    var dynamicColumns;
    var dynamicColumnFrames;
    var rowDataSet;
    var dynamicColumnsnumber;

    function showLocationdetails(ProductId) {
        $("#dvlocationDetailsTab").show();
        $("#locationDetailsTab").show();
        $("#locationDetailsTab > tbody > tr").remove();
        $("#locationDetailsTab > thead > tr").remove();
        var _OrgId = $('#hdnOrgId').val();
        var _OrgAddressId = $('#hdnOrgAddressID').val(); ;
        var _LocationID = $('#hdnLocationId').val();
        var Parameter = { ProductId: ProductId, OrgID: _OrgId, OrgAddressID: _OrgAddressId, LocationId: _LocationID
        };
        $.ajax({
            type: "POST",
            url: "../InventoryCommon/WebService/InventoryWebService.asmx/ProductwithLocationAvilableQty",
            data: JSON.stringify(Parameter),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function Success(data) {
                var Items = data.d;
                var dtDayWCR = Items;
                if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                    // fun_BindValues(dtDayWCR);
                    var parseJSONResult = JSON.parse(dtDayWCR);
                    //Get dynmmic column.
                    dynamicColumns = [];
                    var i = 0;
                    $.each(parseJSONResult[0], function(key, value) {
                        var obj = { sTitle: key };
                        dynamicColumns[i] = obj;
                        i++;
                    });
                    //fetch all records from JSON result and make row data set.
                    rowDataSet = [];
                    var i = 0;
                    $.each(parseJSONResult, function(key, value) {
                        var rowData = [];
                        var j = 0;
                        $.each(parseJSONResult[i], function(key, value) {
                            rowData[j] = value;
                            j++;
                        });
                        rowDataSet[i] = rowData;
                        i++;
                    });
                    BindlocationDetailsTab();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
            }
        });
    }
    function BindlocationDetailsTab() {
        if (rowDataSet != null && rowDataSet.length > 0) {
            $("#locationDetailsTab> tbody > tr").remove();
            $("#locationDetailsTab > thead > tr").remove();
            $('#locationDetailsTab').dataTable({
                "bDestroy": true,
                // "bProcessing": true,
                "bPaginate": false,
                "bDeferRender": true,
                // "bSortable": false,
                "bJQueryUI": true,
                "aaData": rowDataSet,
                'bSort': false,
                'bFilter': false,
                "bScrollCollapse": true,
                "aoColumns": dynamicColumns,
                'sPaginationType': 'full_numbers'
                //"sDom": '<"H"Tfr>t<"F"ip>'
            });
        }
    }
    function hideshowLocationdetails() {
        $('#dvlocationDetailsTab').hide();
    }
</script>
<script type="text/javascript">
         var errorMsg = SListForAppMsg.Get('PurchaseOrder_Error') == null ? "Alert" : SListForAppMsg.Get('PurchaseOrder_Error');
         var informMsg = SListForAppMsg.Get('PurchaseOrder_Information') == null ? "Information" : SListForAppMsg.Get('PurchaseOrder_Information');
         var okMsg = SListForAppMsg.Get('PurchaseOrder_Ok') == null ? "Ok" : SListForAppMsg.Get('PurchaseOrder_Ok')
         var cancelMsg = SListForAppMsg.Get('PurchaseOrder_Cancel') == null ? "Cancel" : SListForAppMsg.Get('PurchaseOrder_Cancel');
         //end

         var datadiv_tooltip = false;
         var datadiv_tooltipShadow = false;
         var datadiv_shadowSize = 4;
         var datadiv_tooltipMaxWidth = 200;
         var datadiv_tooltipMinWidth = 100;
         var datadiv_iframe = false;
         var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
         function showTooltip(e, tooltipTxt) {

             var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

             if (!datadiv_tooltip) {
                 datadiv_tooltip = document.createElement('DIV');
                 datadiv_tooltip.id = 'datadiv_tooltip';
                 datadiv_tooltipShadow = document.createElement('DIV');
                 datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

                 document.body.appendChild(datadiv_tooltip);
                 document.body.appendChild(datadiv_tooltipShadow);

                 if (tooltip_is_msie) {
                     datadiv_iframe = document.createElement('IFRAME');
                     datadiv_iframe.frameborder = '5';
                     datadiv_iframe.style.backgroundColor = '#FFFFFF';
                     datadiv_iframe.src = '#';
                     datadiv_iframe.style.zIndex = 100;
                     datadiv_iframe.style.position = 'absolute';
                     document.body.appendChild(datadiv_iframe);
                 }

             }

             //datadiv_tooltip.style.display = 'block';
             $('#datadiv_tooltip').removeClass().addClass('show');
             //datadiv_tooltipShadow.style.display = 'block';
             $('#datadiv_tooltipShadow').removeClass().addClass('show');
            if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

             var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
             if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
             var leftPos = e.clientX + 10;

             datadiv_tooltip.style.width = null; // Reset style width if it's set 
             datadiv_tooltip.innerHTML = tooltipTxt;
             datadiv_tooltip.style.left = leftPos + 'px';
             datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';


             datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
             datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

             if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
            // datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
             }

        //var tooltipWidth = datadiv_tooltip.offsetWidth;
             if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


        //datadiv_tooltip.style.width = tooltipWidth + 'px';
        //datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
             datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

             if ((leftPos + tooltipWidth) > bodyWidth) {
                 datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
                 datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
             }

             if (tooltip_is_msie) {
                 datadiv_iframe.style.left = datadiv_tooltip.style.left;
                 datadiv_iframe.style.top = datadiv_tooltip.style.top;
            //    datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
                 datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';

             }

         }

         function hideTooltip() {
             //datadiv_tooltip.style.display = 'none';
             $('#datadiv_tooltip').removeClass().addClass('hide');
             //datadiv_tooltipShadow.style.display = 'none';
             $('#datadiv_tooltipShadow').removeClass().addClass('hide');
        if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
         }

    </script>
<script src="../PlatForm/Scripts/DataTable/js/jquery.dataTables.js" type="text/javascript"></script>
<script src="../PlatForm/Scripts/DataTable/TableTools.js" type="text/javascript"></script>
<script src="../PlatForm/Scripts/DataTable/js/dataTables.tableTools.js" type="text/javascript"></script>
<script src="../PlatForm/Scripts/DataTable/js/ZeroClipboard.js" type="text/javascript"></script>
</html>
