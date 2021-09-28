<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditBill.aspx.cs" Inherits="Reception_EditBill" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Bill</title>
    
   <style type="text/css">
   .theader 
   {    
        }
        
   #tbledititems td
   {padding-top:8px;
    padding-bottom:8px;
    padding-left:5px;
    padding-right:5px;
   
    }
    .ui-autocomplete
    {width:250px;
     cursor:pointer;}

td .dueDetails
{    text-align: center;
    padding-top: 50px;
    padding-bottom: 50px;
    font-size: 20px;
    font-weight: 700;}
#tbledititems  .trow:nth-child(odd) 
{
    background: #E1EEF4; color: #00496B; color:#00496B;}

#tbledititems  .trow:nth-child(even) 
{
    background: #fff; color: #00496B; color:#00496B;}
    
  /* #tbledititems  tr td{ border: 1px solid #7f7f7f;}--%> */

.trow td:nth-child(1)
{border-bottom: 1px solid #7f7f7f;
 border-left:1px solid #E1EEF4;
 width:6%;
 }
 .trow td:nth-child(2)
{border-bottom: 1px solid #7f7f7f;
 border-left:1px solid #E1EEF4;
 width:40%;
 }
  .trow td:nth-child(3)
{border-bottom: 1px solid #7f7f7f;
 border-left:1px solid #E1EEF4;
 width:12%;
 }
  .trow td:nth-child(4)
{border-bottom: 1px solid #7f7f7f;
 border-left:1px solid #E1EEF4;
 width:12%;
 }
  .trow td:nth-child(5)
{border-bottom: 1px solid #7f7f7f;
 border-left:1px solid #E1EEF4;
 width:10%;
 }
  .trow td:nth-child(6)
{border-bottom: 1px solid #7f7f7f;
 border-left:1px solid #E1EEF4;
 width:10%;
 }
   .trow td:nth-child(7)
{border-bottom: 1px solid #7f7f7f;
 border-left:1px solid #E1EEF4;
 width:10%;
 }

   
    tr .header th
   {
       border-left:1px solid #E1EEF4;
       border-bottom: 1px solid #7f7f7f;
    background-color: #ffffff ! important;
    padding-top:8px;
    padding-bottom:8px;
    color: #1c94c4;
    margin: 5 auto;
    font-family: Times New Roman;
    font-size: 13px;
    font-weight: bold;
    height: 15px;
    position: relative;
    display: marker;
    right: inherit;
   }
   tr .footer td
   {
    border-left:1px solid #E1EEF4;
    background-color: #ffffff ! important;
    padding-top:8px;
    padding-bottom:8px;
    color: #1c94c4;
    margin: 5 auto;
    font-family: Times New Roman;
    font-size: 13px;
    font-weight: bold;
    height: 15px;
    position: relative;
    display: marker;
    right: inherit;
   }
   tr .border td
 { border-bottom: 1px solid #7f7f7f;
   border-top: 1px solid #7f7f7f;
   border-left:none;}
   
   </style>
   <script type="text/javascript">

       var OrderedList = [];
       var ExistingList = [];
       
       var objSaveParms = {};
       
       function onInvTxtOnblur(ctrl)
       {
           var row = $(ctrl).closest('tr');
           var invLabel = $(row).find('.invlabel');
           var invTextbox = $(row).find('.invaoutocomplete');
           $(invTextbox).hide();
           $(invTextbox).val('');
           $(invLabel).show();
          
       
       }
          function Edit_OnClick(ctrl) {
             var row = $(ctrl).closest('tr');
             var invTextbox = $(row).find('.invaoutocomplete');
             var invLabel = $(row).find('.invlabel');
             $(invTextbox).val('');
             $(invTextbox).show();
             $(invTextbox).focus();
         }

         function InvAutoComplete() {
             $('.invaoutocomplete').autocomplete({

                 source: function(request, response) {
                     $.ajax({
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "../OPIPBilling.asmx/GetBillingItemsForBillEdit",
                         data: JSON.stringify({ prefixText: request.term, contextKey: 'COM~0~~~~', lstOrderedInvestigations: AutoInvList }),
                         dataType: "json",
                         success: function(data) {
                             if (data.d.length > 0) {
                                 // var lst=   JSON.parse(data.d)
                                 response($.map(data.d, function(item) {
                                     var rsltlable = item.Descrip;
                                     var rsltvalue = item.ProcedureName;
                                     return {
                                         label: rsltlable,
                                         val: rsltvalue
                                     }
                                 }))
                             }
                             else {
                                 response([{ label: "No Records Found", val: -1}]);

                             }
                         },
                         error: function(response) {
                             // alert(response.responseText);
                         },
                         failure: function(response) {
                             // alert(response.responseText);
                         }
                     });
                 },


                 select: function(e, i) {
                     if (i.item.val == -1) {
                         //$("#hdnInstrumentID").val("");
                     }
                     else {

                         var val = i.item.val.split(":");
                        var  value = val[0].split("^");
                         AddBillingItemsDetails(value[0], value[2], value[1],this);

                     }
                 },
                 minLength: 2

             });
     }
     function SaveBillEditDetails() {
         var found_lst = $.grep(OrderedList, function(v) {
             return v.IsUpdate === "Y" ;
         });
         if (found_lst.length > 0) {
             objSaveParms.lstPatientDueChart = found_lst;

             $.ajax({
                 type: "POST",
                 url: "../OPIPBilling.asmx/SaveBillEditDetails",
                 data: JSON.stringify(objSaveParms),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 async: true,
                 success: function(data) {
                     var Items = data.d;
                     if (Items > 0) {
                         alert('Bill saved successfully');
                         window.location = '../Billing/HospitalBillSearch.aspx';
                     }
                     else {
                         alert('Something Went Wrong while saving bill details..');
                     }

                 },
                 failure: function(msg) {
                     alert('Something Went Wrong while saving bill details..');
                 }
             });
         }
         else {
             alert('There is no changes in Bill Items.');
         }
     }
     function LoadOrderedItems(parms) {
         $.ajax({
             type: "POST",
             url: "../OPIPBilling.asmx/GetOrderedItemsForBillEdit",
             data: JSON.stringify(parms),
             
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             async: true,
             success: function(data) {
                 var Items = data.d;

                 BindItems(Items);

             },
             failure: function(msg) {
                 ShowErrorMessage(msg);
             }
         });
     }
     var discountPercent = 0;
     var RefundedAmount = 0;
     function BindItems(data) {
         
         if (data.length > 0) {
             var tbody = "";
             var grassTotal = 0;
             var grandTotal = 0;
             var discount = 0;
             var netAmount = 0;
             var AmountReceived = 0;
             discountPercent = 0;
             if (data[1] != null && data[1].length > 0 && parseFloat(data[1][0].Due) <=0 ) {
                 $.each(data[0], function(id, val) {
                     var obj = {};
                     obj.FeeID = val.FeeId;
                     obj.FeeType = val.FeeType;
                     obj.Amount = val.Amount;
                     obj.Description = val.FeeDescription;
                     obj.ActualAmount = val.Amount;
                     obj.DetailsID = val.BillingDetailsID;
                     obj.DiscountPercent = val.DiscountPercent;
                     obj.DiscountAmount = val.DiscountAmount;
                     obj.RedeemAmount = val.RedeemAmount;
                     obj.IsUpdate = 'N';
                     OrderedList.push(obj);
                     var objj = {};
                     objj.ID = parseInt(val.FeeId);
                     objj.Type = val.FeeType;
                     AutoInvList.push(objj);
                     discountPercent = val.DiscountPercent;
                     RefundedAmount = parseFloat(RefundedAmount) + parseFloat(val.RedeemAmount);

                     var idd = id + 1;
                     tbody = tbody + '<tr class="trow"><td>' + idd + '</td><td>';
                     tbody = tbody + ' <input BillingDetailsID="' + val.BillingDetailsID + '" FeeID="' + val.FeeId + '" type="text" style="display:none;" class="invaoutocomplete AutoCompletesearchBox" onblur="onInvTxtOnblur(this)"/>';
                     tbody = tbody + ' <label class="invlabel">' + val.FeeDescription + '</label></td>';
                     tbody = tbody + ' <td class="tdAmount">' + val.Amount.toFixed(2) + '</td><td class="tdDiscountAmount">' + val.DiscountAmount.toFixed(2) + '</td><td>' + val.DiscountPercent + '</td><td class="tdRefund">' + val.RedeemAmount.toFixed(2) + '</td><td>';
                     if (val.IsReimbursable == 'N') {
                         tbody = tbody + '  <input value="Edit" onclick="javascript:Edit_OnClick(this)" class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer">';
                     }
                     tbody = tbody + '</td></tr>';

                 });

                 ExistingList = jQuery.extend(true, [], OrderedList);

                 $('#tbledititems tbody').html('');
                 $('#tbledititems tbody').append(tbody);

                 if (data.length > 1) {
                     var amtDetails = data[1];
                     grassTotal = amtDetails[0].GrossBillValue;
                     grandTotal = parseFloat(amtDetails[0].GrossBillValue) - parseFloat(amtDetails[0].DiscountAmount);
                     discount = amtDetails[0].DiscountAmount;
                     netAmount = amtDetails[0].NetValue;
                     AmountReceived = amtDetails[0].AmountReceived;
                     $('#tdGrandTotal').html(grandTotal.toFixed(2));
                     $('#tdGrossAmount').html(grassTotal.toFixed(2));
                     $('#tdDiscount').html(discount.toFixed(2));
                     AmountReceived = parseFloat(AmountReceived) - parseFloat(RefundedAmount);
                     $('#tdNetAmount').html(AmountReceived.toFixed(2));
                     $('#tdRefundedAmount').html(RefundedAmount.toFixed(2));
                 }
                 InvAutoComplete();
                 $('#tbledititems').show();
                 $('#tblduedetails').hide();
             }
             else {
                 $('#tbledititems').hide();
                 $('#tblduedetails').show();
             }
         }
     }
     function OnAutocompleteSelect() {

         $("#txtName").on("autocompleteselect", function(event, ui) {
             var value = ui.item.value.split(":");
             var city = value[0];
             $("#txtName").val(city);
             if (ui.item.val == -1) {
                 $("#hdnInstrumentID").val("");
             }
             else {
                 $('#hdnSelectedPatientTempDetails').val(ui.item.val);
                 SelectedPatientClient(ui.item.val);
                 event.preventDefault();
             }
         });

     }
     
    </script>
</head>


<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
   
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    
    <div>
    <div runat="server" id="divPatientDetails">
                <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
    </div>
    <div id="divDueDetails">
    <table id="tblduedetails" class="dataheaderInvCtrl w-100p searchPanel" >
    <tbody>
    <tr>
    <td class="dueDetails">Unable to edit the bill- The patient has due..</td>
    </tr>
    </tbody>
    </table>
    
    </div>
    
    
    
    <table border="0" id="tbledititems" style="display:none;" cellpadding="0" cellspacing="0" class="dataheaderInvCtrl w-100p searchPanel">
   <thead>
    <tr class="Duecolor h-22 a-center">
    <th colspan="7" style="font-weight:bold;padding: 8px;"> Edit Items</th>
    </tr>
    <tr class="header">
     <th>S.NO</th>
     <th>Test Name</th>
      <th>Amount</th>
       <th>Discount
           Amount</th>
           <th>Discount
           Percentage</th>
           <th>Refunded 
           Amount</th>
           <th>Action</th></tr>
    </thead> 
      <tbody>

      </tbody> 
  <tfoot >  
      <tr class="footer">
      <td  style="text-align: right;padding-right: 10px;" colspan="2" >Gross Amount : </td>
      <td colspan="5" style="font-weight:normal; color:#00496B;" id="tdGrossAmount">800.00</td>
      
    </tr>
    <tr class="footer">
      <td id="Td2" style="text-align: right;padding-right: 10px;" colspan="2">(10%) Discount (-) :</td>
      <td colspan="5" style="font-weight:normal; color:#00496B;" id="tdDiscount">80.00</td>
      
    </tr>
        <tr class="footer">
      <td  style="text-align: right;padding-right: 10px;" colspan="2">Grand Total :</td>
      <td colspan="5" style="font-weight:normal; color:#00496B;" id="tdGrandTotal">720.00</td>
       </tr>
     <tr class="footer">
      <td id="Td1" style="text-align: right;padding-right: 10px;" colspan="2">Refunded Amount :</td>
      <td colspan="5" style="font-weight:normal; color:#00496B;" id="tdRefundedAmount">720.00</td>
     
      </tr>
    </tr>
     <tr class="footer">
      <td id="Td3" style="text-align: right;padding-right: 10px;" colspan="2">Net Amount :</td>
      <td colspan="5" style="font-weight:normal; color:#00496B;" id="tdNetAmount">720.00</td>
     
      </tr>
      
      <tr class="footer border" >
      <td id="Td5" style="text-align: right;padding-right: 10px;" colspan="2">
      <input type="button" onclick="SaveBillEditDetails();" id="btnSave" class="btn"  value="Save" />
      </td>
      <td colspan="4" style="font-weight:normal; color:#00496B;" id="td6">
      <input type="button" onclick="CancelBillEditDetails();" class="btn"  id="btnCancel" value="Cancel" /></td>
      
      </tr>
      </tfoot>
      </table>
    
    
    
    </div>
    
      <script type="text/javascript">
          var URLparaMeters = [];
          var pOrgID = 0;
          var AutoInvList = [];
          function CancelBillEditDetails() {
              window.location = '../Billing/HospitalBillSearch.aspx';
          }
          $(function() {
              pOrgID = '<%=Session["OrgID"] %>';
              URLparaMeters = getUrlVars();
              var obj = {};
              obj.FinalBillID = URLparaMeters['bid']
              obj.visitID = URLparaMeters['vid']
              LoadOrderedItems(obj);

          });
          function getUrlVars() {
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }
            
            function AddBillingItemsDetails(feeid,feetype,descrip,ctrl) {
         var obj = {};
         obj.OrgID = pOrgID;
         obj.FeeID = feeid;
         obj.FeeType=feetype;
         obj.Description=descrip;
         obj.ClientID = $('#PatientDetail_hdnClientID').val();
         obj.VisitID = URLparaMeters['vid'];
         obj.Remarks = '';
         obj.IsCollected = 'N';
         obj.CollectedDatetime= new Date();
         obj.locationName='';
         $.ajax({
             type: "POST",
             contentType: "application/json; charset=utf-8",
             url: "../OPIPBilling.asmx/GetBillingItemsDetails",
             data: JSON.stringify(obj),
             dataType: "json",
             async: false,
             success: function(data) {
                 if (data.d.length > 0) {
                     for (var i = 0; i < data.d.length; i++) {
                         arrGotValue = data.d[0].ProcedureName.split('^');
                         if (arrGotValue.length > 0) {
                             ID = arrGotValue[0];
                             name = arrGotValue[1].trim();
                             feeType = arrGotValue[2];
                             var row = $(ctrl).closest('tr');
                             var invLabel = $(row).find('.invlabel');
                             var invTextbox = $(row).find('.invaoutocomplete');
                             var billDetailsID = $(invTextbox).attr('BillingDetailsID');
                             FeeID = $(invTextbox).attr('FeeID');
                             $(invTextbox).attr('FeeID', ID);
                             $(invTextbox).hide();
                             $(invTextbox).val('');
                             $(invLabel).text(name);
                             $(invLabel).show();
                             var amount = parseFloat(arrGotValue[3]);
                             ActualAmount = parseFloat(arrGotValue[8]);
                             disAmount = (amount * parseInt(discountPercent)) / 100;
                             total = parseFloat(amount) - parseFloat(disAmount);
                             lblDiscountAmount = $(row).find('.tdDiscountAmount').val(disAmount);
                             lblAmount = $(row).find('.tdAmount').val(amount);
                             $(lblDiscountAmount).html(disAmount.toFixed(2));
                             $(lblAmount).html(amount.toFixed(2));
                             var GrossAmount = 0;

                             AutoInvList = [];
                             $.each(OrderedList, function(id, val) {
                                 if (val.FeeID == FeeID && val.DetailsID == billDetailsID) {
                                     OrderedList[id].FeeID = parseInt(ID);
                                     OrderedList[id].Description = name;
                                     OrderedList[id].DiscountAmount = disAmount.toFixed(2);
                                     OrderedList[id].Type = feeType;
                                     OrderedList[id].Amount = amount.toFixed(2);
                                     OrderedList[id].ActualAmount = ActualAmount.toFixed(2);
                                     OrderedList[id].IsUpdate = 'Y';

                                 }
                                 if (val.IsUpdate == 'Y') {
                                     var objj = {};
                                     objj.ID = OrderedList[id].FeeID;
                                     objj.Type = OrderedList[id].Type;
                                     AutoInvList.push(objj);
                                 }

                                 GrossAmount = GrossAmount + parseFloat(val.Amount);

                             });

                             DiscountAmount = (GrossAmount * parseInt(discountPercent)) / 100;

                             grandTotal = parseFloat(GrossAmount) - parseFloat(DiscountAmount);

                             $.each(ExistingList, function(id, n) {
                                 var objj = {};
                                 objj.ID = ExistingList[id].FeeID;
                                 objj.Type = ExistingList[id].Type;
                                 AutoInvList.push(objj);

                             });

                             var objlst = {};
                             objlst.pOrgID = pOrgID;
                             objlst.pGrossBillValue = parseFloat(GrossAmount);
                             objlst.pDiscountAmount = parseFloat(DiscountAmount);
                             objlst.pNetValue = parseFloat(grandTotal);
                             objlst.pVisitID = URLparaMeters['vid'];
                             objlst.pClientID = $('#PatientDetail_hdnClientID').val();
                             objlst.pBillID = URLparaMeters['bid'];
                             objlst.lstPatientDueChart = OrderedList;
                             objSaveParms = {};
                             objSaveParms = objlst;
                             $('#tdGrossAmount').html(GrossAmount.toFixed(2));
                             $('#tdDiscount').html(DiscountAmount.toFixed(2));
                             $('#tdGrandTotal').html(grandTotal.toFixed(2));
                             grandTotal = parseFloat(grandTotal) - parseFloat(RefundedAmount);
                             $('#tdNetAmount').html(grandTotal.toFixed(2));


                         }
                     }
                 }
                 else {
                     DuplicateInv(FeeID, FeeType);
                     //alert('Item Amount is Zero, you cannot add this item for billing');
                     document.getElementById('billPart_txtTestName').value = '';
                     document.getElementById('billPart_txtTestName').focus();
                 }
             },
             error: function(result) {
                 var objSelClient = SListForAppMsg.Get("Scripts_CommonBiling_js_10") == null ? "Select the ClientName From List" : SListForAppMsg.Get("Scripts_CommonBiling_js_10");
                 objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                 ValidationWindow(objSelClient, objAlert);

                 //alert("Select the ClientName From List");
             }
         });

     }
          </script>
          
 
    
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
        
</body>
</html>
