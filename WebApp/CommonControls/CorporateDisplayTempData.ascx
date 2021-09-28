<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CorporateDisplayTempData.ascx.cs" Inherits="CommonControls_CorporateDisplayTempData" %>
<asp:Panel ID="pres" runat="server" meta:resourcekey="presResource1">
    <table cellpadding="0" width="80%" cellspacing="0" border="0" align="center">
        <tr>
            <td style="display:none">
                <asp:Label ID="Rs_AddedItems" runat="server" Text="Added Items" 
                    meta:resourcekey="Rs_AddedItemsResource1" ></asp:Label>
            </td>
            <td align="right" style="padding-right: 20px; font-weight: bold; display:none">
                <asp:Label ID="Rs_NonMedicalItems" runat="server" Text="Non-Medical Items: " 
                    meta:resourcekey="Rs_NonMedicalItemsResource1"></asp:Label>
                <asp:Label ID="lblNonReimburseAmt" runat="server" Text="0.00" 
                    meta:resourcekey="lblNonReimburseAmtResource1"></asp:Label>
                &nbsp;&nbsp; 
                <asp:Label ID="Rs_TotalAmount" runat="server" Text="Total Amount: " 
                    meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                <asp:Label ID="lblTotalAmt" runat="server" Text="0.00" 
                    meta:resourcekey="lblTotalAmtResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="padding: 0 5px 0 5px;">
                <div id="dvPaymentTable" runat="server" style="width: 99%;">
                </div>
            </td>
        </tr>
    </table>
</asp:Panel>

<script type="text/javascript" language="javascript">
    function ClearPaymentControlEventsDAD() {
        document.getElementById('<%= hdfBillType1.ClientID %>').value = "";
        CreatePaymentTablesDaD();
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = "0.00";
        document.getElementById("<%= hdnGrossAmount.ClientID %>").value = "0.00";
        document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = "0.00";

    }

    function CmdAddBillItemsType_onclick(FeeType, FeeID, OtherID, Descrip, Perphyname, PerphyID, Quantity, Amount, Total, DTime, IsRI, DisorEnhpercent, DisorEnhType, Remarks) {
        var FeeViewStateValue = document.getElementById('<%= hdfBillType1.ClientID %>').value;
        var refDetails = GetRefPhysicianDetails("ReferDoctor1");
        var refType = refDetails.split('~')[0];
        var refPhyID = refDetails.split('~')[1];
        var refPhyName = refDetails.split('~')[2];


        var FeeGotValue = new Array();
        FeeGotValue = FeeViewStateValue.split('|');
        var feeIDALready = new Array();
        var tempFeeID, tempFeeType, tempOtherID, tempDateTime, tempDescrip,tempPerphyname,tempPerphyID;


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
                    if (arrayChildData[0] == "DTime") {
                        tempDateTime = arrayChildData[1];
                    }

                    if (arrayChildData[0] == "Descrip") {
                        tempDescrip = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Perphyname") {
                        tempPerphyname = arrayChildData[1];
                      
                    }
                    if(arrayChildData[0]=="PerphyID")
                    {
                    tempPerphyID =arrayChildData[1];
                    }
                    
                    if (FeeID == tempFeeID && FeeType == tempFeeType && Descrip == tempDescrip && OtherID == tempOtherID && tempDateTime == DTime) {
                        iPaymentAlreadyPresent = 1;
                    }
                }
            }

        }


        if (iPaymentAlreadyPresent == 0) {
            FeeViewStateValue += "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^" + PerphyID  + "~Quantity^" + Quantity + "~Amount^"
                + Amount + "~Total^" + Total + "~DTime^"+ DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName +"~DisorEnhpercent^"+DisorEnhpercent+"~DisorEnhType^"+DisorEnhType+"~Remarks^"+Remarks+"|";
            document.getElementById('<%= hdfBillType1.ClientID %>').value = FeeViewStateValue;
            addAmount(Total, IsRI);
            CreatePaymentTablesDaD();
            

        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\CorporateDisplayTempData.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert("Item already added");
            }
        }

    }


    function CreatePaymentTablesDaD() {

        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML = "";
        var newPaymentTables, startPaymentTag, endPaymentTag;
        var FeeViewStateValue = document.getElementById('<%= hdfBillType1.ClientID %>').value;
        startPaymentTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' style='display:none;'>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_FeeType %>"+" </th><th scope='col' style='display:none;'>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_FeeID %>"+"</th> <th scope='col' style='display:none;'> "+" <%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_OtherID %>"+"</th> <th scope='col' align='left' > "+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Description %>"+" </th> <th scope='col' align='right' style='display:none;'> "+" <%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Perphyname %>"+" </th> <th scope='col' align='left'>"+" <%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Quantity %>"+"</th><th scope='col' align='right' style='display:none;'> "+" <%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Amount %>"+" </th><th scope='col' align='right' style='display:none;'> "+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Total %> "+" </th><th scope='col' align='center' style='display:none;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Date %> "+" </th><th scope='col' align='center' style='display:none;'> "+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_IsReimbursable %> "+" </th><th scope='col' style='display:none;'> "+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_DisorEnhpercent %> "+" </th><th scope='col' style='display:none;'> "+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_DisorEnhType %> "+" </th><th scope='col' style='display:none;'> "+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Remarks %>"+" </th><th scope='col' align='left'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Delete_1 %>"+"</th></tr>";
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
                        if (arrayChildData[0] == "Descrip") 
                        {
                            Descrip = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Perphyname") {
                            Perphyname = arrayChildData[1];

                        }
                        if (arrayChildData[0] == "PerphyID") {
                            PerphyID = arrayChildData[1];

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
                        if (arrayChildData[0] == "DTime") {
                            DTime = arrayChildData[1];
                        }

                        if (arrayChildData[0] == "IsReimbursable") {
                            IsRI = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "refType") {
                            refType = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "refPhyID") {
                            refPhyID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "refPhyName") {
                            refPhyName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DisorEnhpercent") {
                            DisorEnhpercent = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DisorEnhType") {
                            DisorEnhType = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Remarks") {
                            Remarks = arrayChildData[1];
                        }
                        

                    }
                }
                var chkBoxName = "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname +"~PerphyID^" +PerphyID + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + +"~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName + "";

                newPaymentTables += "<TR><TD style='display:none;'>" + FeeType + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + FeeID + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + OtherID + "</TD>";
                newPaymentTables += "<TD style='padding-left:10px' align='left'>" + Descrip + "</TD>"
                newPaymentTables += "<TD style='display:none;' align='left'>" + Perphyname + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + PerphyID + "</TD>";
                newPaymentTables += "<TD align='left'>" + Quantity + "</TD>";
                newPaymentTables += "<TD  align='right' style='display:none;'>" + Amount + "</TD>";
                newPaymentTables += "<TD  align='right' style='display:none;'>" + Total + "</TD>";
                newPaymentTables += "<TD  align='center' style='display:none;'>" + DTime + "</TD>";
                newPaymentTables += "<TD  align='center' style='display:none;'>" + IsRI + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + DisorEnhpercent + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + DisorEnhType + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + Remarks + "</TD>";
                newPaymentTables += "<TD><input name='RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^" + PerphyID + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName + "~DisorEnhpercent^" + DisorEnhpercent + "~DisorEnhType^" + DisorEnhType + "~Remarks^" + Remarks + "' onclick='btnPaymentDelete_OnClick1(name);' value ='<%=Resources.ClientSideDisplayTexts.CommonControls_CorporateDisplayTempData_Delete_2 %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
                //DisableReferDoctor("ReferDoctor2", "Y");
            }
        }

        newPaymentTables += endPaymentTag;
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML += newPaymentTables;


    }


    function btnPaymentDelete_OnClick1(sEditedData) {

        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;

        var PaymenttempDatas = document.getElementById('<%= hdfBillType1.ClientID %>').value;

        PaymentAAlreadyPresent = PaymenttempDatas.split('|');
        if (PaymentAAlreadyPresent.length > 0) {
            for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
                if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() == sEditedData.toLowerCase()) {

                    var tempFeeID, tempFeeType, tempOtherID, iChild, tempFeeDate, tempNRI;
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
                            if (arrayChildData[0] == "DTime") {
                                tempFeeDate = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "IsReimbursable") {
                                tempNRI = arrayChildData[1];
                            }
                        }
                    }

                    if ("PKG" == tempFeeType) {
                        //showorHidechkBox(tempFeeID);
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
            arramt = FeeGotValue[9];
            amtreceived = arramt.split('^')[1];
            deleteAmount(amtreceived, FeeGotValue[11].split('^')[1]);
        }
        document.getElementById('<%= hdfBillType1.ClientID %>').value = PaymenttempDatas;
        CreatePaymentTablesDaD();

        //AddAmountinTextbox();

    }



    function btnPaymentDeleteFeeID_OnClick(FeeType, FeeID, OtherID, Descrip,Perphyname,PerphyID, Quantity, Amount, Total, DTime, IsRI) {
        var FeeViewStateValue = "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^"+ PerphyID + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName;
        btnPaymentDelete_OnClick1(FeeViewStateValue);

    }


    function addAmount(addedAmount, nriFlag) {

        var sVal = document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML;
        sVal = format_number(Number(addedAmount) + Number(sVal), 2);
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = sVal;
        document.getElementById("<%= hdnGrossAmount.ClientID %>").value = sVal;
        if (nriFlag == "No") {
            var nriVal = document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML;
            nriVal = format_number(Number(addedAmount) + Number(nriVal), 2);
            document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = nriVal;
        }
    }

    function deleteAmount(deletedAmount, nriFlag) {
        var sVal = document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML;
        sVal = format_number(Number(sVal) - Number(deletedAmount), 2);
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = sVal;
        document.getElementById("<%= hdnGrossAmount.ClientID %>").value = sVal;
        if (nriFlag == "No") {
            var nriVal = document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML;
            nriVal = format_number(Number(nriVal) - Number(deletedAmount), 2);
            document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = nriVal;
        }
    }
    function ClearDisplayData() {
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = "0.00";
        document.getElementById("<%= hdnGrossAmount.ClientID %>").value = "0.00";
        document.getElementById("<%= hdfBillType1.ClientID %>").value = '';
        document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = "0.00";
    }
 
    
    
    
</script>

<asp:HiddenField ID="hdfBillType1" runat="server" />
<%--<asp:HiddenField ID="hdnPaymentExists" runat="server" />--%>
<asp:HiddenField ID="hdnPaymentsDeleted" runat="server" />
<asp:HiddenField ID="hdnGrossAmount" Value="0.00" runat="server" />
