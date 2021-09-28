<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DisplayIPData.ascx.cs" Inherits="UserControl_DisplayIPData" %>
<asp:Panel ID="pres" runat="server" Width="650px" 
    meta:resourcekey="presResource1" >
    <table  cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr >
            <td class="dataheaderInvCtrl">
                <asp:Label ID="Rs_AddedItems" runat="server" Text="Added Items :" 
                    meta:resourcekey="Rs_AddedItemsResource1"></asp:Label>
            <div id="dvTotal" style="width:100%" align="right">
                <asp:Label ID="Rs_TotalAmount" runat="server" Text="Total Amount :" 
                    meta:resourcekey="Rs_TotalAmountResource1"></asp:Label> 
                <asp:Label ID="lblTotalAmt" runat="server" Text="0" 
                    meta:resourcekey="lblTotalAmtResource1" ></asp:Label> &nbsp;&nbsp;&nbsp;</div>
             <div ID="dvPaymentTable" class="dataheaderInvCtrl" runat="server"  style="width:100%"></div>
                  </td>
        </tr>
    </table>
     
</asp:Panel>
<script type="text/javascript" language="javascript">
    function ClearPaymentControlEvents() {
        document.getElementById('<%= hdfBillType.ClientID %>').value = "";
        CreatePaymentTables();

    }
 
    function CmdAddBillItemsType_onclick(FeeType, FeeID, OtherID, Descrip, Quantity, Amount, Total,Comments,FromDate,ToDate) {
        var FeeViewStateValue = document.getElementById('<%= hdfBillType.ClientID %>').value;


        var FeeGotValue = new Array();
        FeeGotValue = FeeViewStateValue.split('|');
        var feeIDALready = new Array();
        var tempFeeID, tempFeeType,tempOtherID,tempDescrip,tempFromDate,tempToDate;

        
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;
        var arrayMainData = new Array();
        var arrayChildData = new Array();
        
        for (iMain = 0; iMain < FeeGotValue.length - 1; iMain++) {

            arraySubData = FeeGotValue[iMain].split('~');
            for (iChild = 0; iChild < arraySubData.length; iChild++) {
                arrayChildData = arraySubData[iChild].split('^');
                if (arrayChildData.length > 0) {
                    
                    if (arrayChildData[0] == "FeeID") {
                        tempFeeID = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "FeeType") {
                        tempFeeType = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "OtherID") {
                        tempOtherID = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "FromDate") {
                        tempFromDate = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "ToDate") {
                        tempToDate = arrayChildData[1];
                    }
                    if (FeeID == tempFeeID && FeeType == tempFeeType && OtherID == tempOtherID && FromDate == tempFromDate && ToDate == tempToDate) {
                        iPaymentAlreadyPresent = 1;
                    }
                }
            }
           
        }
        

        if (iPaymentAlreadyPresent == 0) {
            FeeViewStateValue += "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~Comments^" + Comments + "~FromDate^" + FromDate + "~ToDate^" + ToDate + "|";
            document.getElementById('<%= hdfBillType.ClientID %>').value = FeeViewStateValue;
            addAmount(Amount);
            CreatePaymentTables();
            
        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DisplayIPData.ascx');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert("Item already added"); }
        }

    }
    
     
    function CreatePaymentTables() {
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML = "";
        var newPaymentTables, startPaymentTag, endPaymentTag;
        var FeeViewStateValue = document.getElementById('<%= hdfBillType.ClientID %>').value;

        startPaymentTag = "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' Border='1' style='BackgroundColor:#ff6600;' class='' ><TBODY><tr><td style='display:none;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_FeeType %>"+"</td><td style='display:none;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_FeeID %>"+"</td> <td style='display:none;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_OtherID %>"+"</td> <td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_Description_1 %>"+"</td> <td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_Quantity %>"+"</td><td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_Amount %>"+"</td><td>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_Total %>"+"</td><td>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_Description_2 %>"+"</td><td>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_FromDate %>"+"</td><td>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_ToDate%>"+"</td><td></td></tr>";
        endPaymentTag = "</TBODY></TABLE>";
        newPaymentTables = startPaymentTag;

        var arrayMainData = new Array();
        var arraySubData = new Array();
        var arrayChildData = new Array();
        var iMain = 0;
        var iChild = 0;

        arrayMainData = FeeViewStateValue.split('|');
        if (arrayMainData.length > 0) {
            for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {

                arraySubData = arrayMainData[iMain].split('~');
                for (iChild = 0; iChild < arraySubData.length; iChild++) {
                    arrayChildData = arraySubData[iChild].split('^');
                    if (arrayChildData.length > 0) {
                        if (arrayChildData[0] == "FeeType") {
                            FeeType = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "FeeID") {
                            FeeID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "OtherID") {
                            OtherID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Descrip") {
                            Descrip = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Quantity") {
                            Quantity = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Amount") {
                            Amount = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Total") {
                            Total = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Comments") {
                            Comments = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "FromDate") {
                            FromDate = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "ToDate") {
                            ToDate = arrayChildData[1];
                        }
                    }
                }
                var chkBoxName = "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "";

                newPaymentTables += "<TR><TD style='display:none;'>" + FeeType + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + FeeID + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + OtherID + "</TD>";
                newPaymentTables += "<TD >" + Descrip + "</TD>";
                newPaymentTables += "<TD >" + Quantity + "</TD>";
                newPaymentTables += "<TD >" + Amount + "</TD>";
                newPaymentTables += "<TD >" + Total + "</TD>";
                newPaymentTables += "<TD >" + Comments + "</TD>";
                newPaymentTables += "<TD >" + FromDate + "</TD>";
                newPaymentTables += "<TD >" + ToDate + "</TD>";
                newPaymentTables += "<TD><input name='RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~Comments^" + Comments + "~FromDate^" + FromDate + "~ToDate^" + ToDate + "' onclick='btnPaymentDelete_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayIPData_Delete %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
            }
        }

        newPaymentTables += endPaymentTag;
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML += newPaymentTables;
        

    }

   
    function btnPaymentDelete_OnClick(sEditedData) {
       
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;

        var PaymenttempDatas = document.getElementById('<%= hdfBillType.ClientID %>').value;
        PaymentAAlreadyPresent = PaymenttempDatas.split('|');
        if (PaymentAAlreadyPresent.length > 0) {
            for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
                if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() == sEditedData.toLowerCase()) {

                    var tempFeeID, tempFeeType, tempOtherID, iChild;
                    var arrayChildData = new Array();

                    arraySubData = PaymentAAlreadyPresent[iPaymentCount].split('~');
                        for (iChild = 0; iChild < arraySubData.length; iChild++) {
                            arrayChildData = arraySubData[iChild].split('^');
                            if (arrayChildData.length > 0) {

                                if (arrayChildData[0] == "FeeID") {
                                    tempFeeID = arrayChildData[1];
                                }
                                if (arrayChildData[0] == "FeeType") {
                                    tempFeeType = arrayChildData[1];
                                }
                            }
                        }

                        if ("PKG" == tempFeeType) {
                            showorHidechkBox(tempFeeID);
                        }
                    PaymentAAlreadyPresent[iPaymentCount] = "";
                }
            }
        }
        PaymenttempDatas = "";
        for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
            if (PaymentAAlreadyPresent[iPaymentCount] != "") {
                PaymenttempDatas += PaymentAAlreadyPresent[iPaymentCount] + "|";
            }
        }

        var FeeGotValue = new Array();
        var arrayAmount = new Array();
     
        FeeGotValue = sEditedData.split('~');
        var FeeID;

        if (FeeGotValue.length > 0) {
            FeeID = FeeGotValue[2];

            arrayAmount = FeeID.split('^');
        }
        var arramt = 0;
        var amtreceived = 0;
        if (FeeGotValue.length > 0) {
            arramt = FeeGotValue[6];
            amtreceived = arramt.split('^')[1];
            deleteAmount(amtreceived);
        }
        document.getElementById('<%= hdfBillType.ClientID %>').value = PaymenttempDatas;
        CreatePaymentTables();
    }




    function btnPaymentDeleteFeeID_OnClick(FeeType, FeeID, OtherID, Descrip, Quantity, Amount, Total,Comments,FromDate,ToDate) {
        var FeeViewStateValue = "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~Comments^" + Comments + "~FromDate^" + FromDate + "~ToDate^" + ToDate;
        btnPaymentDelete_OnClick(FeeViewStateValue)
    }


    function addAmount(addedAmount) {
        
        var sVal = document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML;
        sVal = format_number(Number(addedAmount)+Number(sVal), 2);
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = sVal;
    }

    function deleteAmount(deletedAmount) {
        var sVal = document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML;
        sVal = format_number(Number(sVal) - Number(deletedAmount), 2);
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = sVal;
    }
</script>

<asp:HiddenField ID="hdfBillType" runat="server" />
<%--<asp:HiddenField ID="hdnPaymentExists" runat="server" />--%>
<asp:HiddenField ID="hdnPaymentsDeleted" runat="server" />