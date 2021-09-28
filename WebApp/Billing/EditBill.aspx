<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditBill.aspx.cs" Inherits="Billing_EditBill" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Edit Bill</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:Panel ID="pnlSerch" CssClass="dataheader2" BorderWidth="1px" Width="100%" runat="server"
            meta:resourcekey="pnlSerchResource1">
            <table border="0" cellpadding="0" cellspacing="5" class="w-100p">
                <tr>
                </tr>
                <tr align="center" class="defaultfontcolor">
                    <td>
                        Bill / Visit Number
                    </td>
                    <td align="left" class="defaultfontcolor">
                        <asp:TextBox ID="txtBillNo" runat="server"></asp:TextBox>
                        <input type="button" onclick="LoginBillingDetails()" class="btn" value="Search" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" />
                    </td>
                    <td>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                </tr>
                <tr class="defaultfontcolor">
                </tr>
                <tr class="colorforcontent w-30p h-23 a-left">
                    <td colspan="6">
                        Patient Details
                    </td>
                </tr>
                <tr class="defaultfontcolor">
                </tr>
                <tr>
                    <td class="defaultfontcolor">
                        Patient Name&nbsp; :
                        <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                    </td>
                    <td class="w-20p">
                        Gender :
                        <asp:Label ID="lblGender" runat="server"></asp:Label>
                    </td>
                    <td class="defaultfontcolor">
                        Age :
                        <asp:Label ID="lblAge" runat="server"></asp:Label>
                    </td>
                    <td>
                        Visit No:
                        <asp:Label ID="lblVisitNo" runat="server"></asp:Label>
                    </td>
                    <td>
                        Bill No :
                        <asp:Label ID="lblBillNo" runat="server"></asp:Label>
                    </td>
                    <td>
                        Bill Date:
                        <asp:Label ID="lblBillDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" class="style2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table id="tblOrederedItems" class="gridView w-100p" cellspacing="0" cellpadding="1"
                            rules="all" border="1" style="border-collapse: collapse;">
                        </table>
                    </td>
                </tr>
                <tr>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <table align="center" style="margin-left: 49%;">
                <tr class="defaultfontcolor" colspan="2">
                    <td>
                        Gross Amount
                    </td>
                    <td>
                        <asp:Label ID="lblGrossAmt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr class="defaultfontcolor">
                    <td>
                        Discount Amount
                    </td>
                    <td>
                        <asp:Label ID="lblDiscountAmt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr class="defaultfontcolor">
                    <td>
                        Net Amount
                    </td>
                    <td>
                        <asp:Label ID="lblNetAmt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr class="defaultfontcolor">
                    <td>
                        Received Amount
                    </td>
                    <td>
                        <asp:Label ID="lblRecAmt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
            <table style="margin-left : 40%">
                <tr>
                    <td>
                        <asp:Button ID="btnSave" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            runat="server" onmouseout="this.className='btn'" OnClick="btnSave_Click" OnClientClick="javascript:return SaveEditDate();" />
                        <asp:Button ID="btnCancel" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            runat="server" onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <input type="hidden" id="hdnfinaldetails" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script>
   
        var dbs = [];
        function LoginBillingDetails() {       
        
         debugger;
            var pno=  $("#txtBillNo").val().trim();
            
            if(pno != "")
            {
           // var pno=2;
            try {
            if(pno!="")
            {
            pno="Edit_"+pno;
            var dataToLog = {'billRefNo':pno};
            
                $.ajax({
                    type: "POST",
                    url: "EditBill.aspx/getBillingdetails",
                    data: JSON.stringify(dataToLog) ,
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    success: function (data) {
                     debugger;
                        var fb = data.d;
                        dbs = JSON.parse(fb);     
                        if ((dbs.billindDetails.length != 0)   && (dbs.finalBills.length != 0))
                        {               
                            Tblist();
                        }
                        else
                        {
                          alert("No Records Found.");
                          Tblist();
                          TblistClear();
                        }
                        
                    },
                    error: function (err) {
                        alert('Error while loading data.');
                        TblistClear();
                    }
                });
            }
            }
            catch (e) {
                return false;
            }
            }
            else{
            
               alert("Please Enter the Bill or Visit Number.");
            }
        }
        
        function TotalAmountCalc() {
            var grass = 0;
            finallist = [];
            
                $.each(dbs.billindDetails, function (obj, value) {
                grass = grass + Number($("#tbs" + value.DetailsID).val())

            });
             var discount=  Number(document.getElementById("lblDiscountAmt").innerHTML)

            if((grass-discount)>=0)
            {
            $.each(dbs.billindDetails, function (obj, value) {
                value.Amount = Number($("#tbs" + value.DetailsID).val());
            });
                document.getElementById("lblGrossAmt").innerHTML=   parseFloat(grass).toFixed(2);  
                document.getElementById("lblNetAmt").innerHTML=   parseFloat(grass-discount).toFixed(2);  
                document.getElementById("lblRecAmt").innerHTML=   parseFloat(grass-discount).toFixed(2);   
                
                  dbs.finalBills[0].GrossBillValue=grass
    
                dbs.finalBills[0].NetValue=grass-discount;
                dbs.finalBills[0].AmountReceived=grass-discount;   
            }
            else
            {
            alert("Discount amount greater than netamount"); 
            }
        }
            
       function SaveEditDate()
        {       
            
          document.getElementById("hdnfinaldetails").value=JSON.stringify(dbs)
        return true;;
        }

        function TblistClear() {
              document.getElementById("lblPatientName").innerHTML= "";
              document.getElementById("lblAge").innerHTML=   "";
              document.getElementById("lblGender").innerHTML=   "";
              document.getElementById("lblVisitNo").innerHTML=   "";
              document.getElementById("lblBillNo").innerHTML=   "";
              document.getElementById("lblBillDate").innerHTML=   "";
              document.getElementById("lblGrossAmt").innerHTML=  "0.00";  
              document.getElementById("lblDiscountAmt").innerHTML=  "0.00";    
              document.getElementById("lblNetAmt").innerHTML=   "0.00";     
              document.getElementById("lblRecAmt").innerHTML=   "0.00";  
          
        }


        function Tblist() {

        if(dbs.finalBills.length>0){
        
              document.getElementById("lblPatientName").innerHTML=   dbs.finalBills[0].Name;
              document.getElementById("lblAge").innerHTML=   dbs.finalBills[0].PatientAge;
              document.getElementById("lblGender").innerHTML=   dbs.finalBills[0].Type;
              document.getElementById("lblVisitNo").innerHTML=   dbs.finalBills[0].VersionNo;
              document.getElementById("lblBillNo").innerHTML=   dbs.finalBills[0].BillNumber;
              document.getElementById("lblBillDate").innerHTML=   dbs.finalBills[0].Physician;
              document.getElementById("lblGrossAmt").innerHTML=   parseFloat(dbs.finalBills[0].GrossBillValue).toFixed(2);  
              document.getElementById("lblDiscountAmt").innerHTML=   parseFloat(dbs.finalBills[0].DiscountAmount).toFixed(2);     
              document.getElementById("lblNetAmt").innerHTML=   parseFloat(dbs.finalBills[0].NetValue).toFixed(2);     
              document.getElementById("lblRecAmt").innerHTML=   parseFloat(dbs.finalBills[0].AmountReceived).toFixed(2);     
        }
        
            while (count = document.getElementById('tblOrederedItems').rows.length) {

                for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
                    document.getElementById('tblOrederedItems').deleteRow(j);
                }
            }


            var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "responstableHeader a-center"
//            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(0);
            var cell3 = Headrow.insertCell(1);
            var cell4 = Headrow.insertCell(2);

//            cell1.innerHTML = "Select";
            cell2.innerHTML = "Item Name";
            cell3.innerHTML = "Amount";
            cell4.innerHTML = "Amount Edit";

            $.each(dbs.billindDetails, function (obj, value) {
                var row = document.getElementById('tblOrederedItems').insertRow(1);
                row.style.height = "13px";
//                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(0);
                var cell3 = row.insertCell(1);
                var cell4 = row.insertCell(2);


//                cell1.innerHTML = '<input type="checkbox" name="items" value=""/>';
                cell2.innerHTML = value.Description;
                cell3.innerHTML = value.Amount;
                cell4.innerHTML = '<input type="text" id="tbs' + value.DetailsID + '" onblur="TotalAmountCalc()"  onkeypress="return ValidateOnlyNumeric(this);" name="tbs' + value.DetailsID + '" value="' + value.Amount + '" />';

            });
        }



    </script>

</body>
</html>
