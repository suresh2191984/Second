<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DisplayAllDataTemp.ascx.cs"
    Inherits="UserControl_DisplayAllDataTemp" %>
<asp:Panel ID="pres" runat="server" meta:resourcekey="presResource1">
    <table cellpadding="0" width="100%" cellspacing="0" border="0">
        <tr>
            <td>
                <asp:Label ID="Rs_AddedItems" runat="server" Text="Added Items" 
                    meta:resourcekey="Rs_AddedItemsResource1"></asp:Label>
            </td>
            <td align="right" style="padding-right: 20px; font-weight: bold;">
                <asp:Label ID="Rs_NonMedicalItems" runat="server" Text="Non-MedicalItems :" 
                    meta:resourcekey="Rs_NonMedicalItemsResource1"></asp:Label>
                <asp:Label ID="lblNonReimburseAmt" runat="server" Text="0.00" 
                    meta:resourcekey="lblNonReimburseAmtResource1"></asp:Label>
                &nbsp;&nbsp; 
                <asp:Label ID="Rs_TotalAmount" runat="server" Text="Total Amount :" 
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
      <input type="hidden" id="hdnTempvalue" runat="server" />
</asp:Panel>

<script type="text/javascript" language="javascript">
    function ClearPaymentControlEventsDAD() {
        document.getElementById('<%= hdfBillType1.ClientID %>').value = "";
        CreatePaymentTablesDaD();
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = "0.00";
        document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = "0.00";
        ToTargetFormat($("#<%= lblTotalAmt.ClientID %>"));
        ToTargetFormat($("#<%= lblNonReimburseAmt.ClientID %>"));
    }

    function CmdAddBillItemsType_onclick(FeeType, FeeID, OtherID, Descrip, Perphyname, PerphyID, Quantity, Amount, Total, DTime, IsRI, DisorEnhpercent, DisorEnhType, Remarks, ReimbursableAmount, NonReimbursableAmount,AMBCODE) {
      
        var FeeViewStateValue = document.getElementById('<%= hdfBillType1.ClientID %>').value;
        var refDetails = GetRefPhysicianDetails("ReferDoctor2");
        var refType = refDetails.split('~')[0];
        var refPhyID = refDetails.split('~')[1];
        var refPhyName = refDetails.split('~')[2];
       
        if (refPhyName == '') {
            refDetails = GetRefPhysicianDetails("ReferDoctor1");
            refType = refDetails.split('~')[0];
            refPhyID = refDetails.split('~')[1];
            refPhyName = refDetails.split('~')[2];
        }


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
               
            //FeeViewStateValue += "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^" + PerphyID  + "~Quantity^" + Quantity + "~Amount^"
              //  + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName + "~DisorEnhpercent^" + DisorEnhpercent + "~DisorEnhType^" + DisorEnhType + "~Remarks^" + Remarks + "~ReimbursableAmount^" + ReimbursableAmount + "~NonReimbursableAmount^" + NonReimbursableAmount + "|";
            
            if(ADDAmbulanceDetails()!=true)
            {
                return false;
            }

            var pTempamt = 0;
            var ptempTotal = 0;
            var pTempDisorEnhpercent = 0;
            var ptempReimbursableAmount = 0;
            var ptempNonReimbursableAmount = 0;

            document.getElementById("<%= hdnTempvalue.ClientID %>").value = Amount;
            ToTargetFormat($('#<%= hdnTempvalue.ClientID %>'));
            pTempamt = document.getElementById("<%= hdnTempvalue.ClientID %>").value;

            document.getElementById("<%= hdnTempvalue.ClientID %>").value = Total;
            ToTargetFormat($('#<%= hdnTempvalue.ClientID %>'));
            ptempTotal = document.getElementById("<%= hdnTempvalue.ClientID %>").value;

            document.getElementById("<%= hdnTempvalue.ClientID %>").value = DisorEnhpercent;
            ToTargetFormat($('#<%= hdnTempvalue.ClientID %>'));
            pTempDisorEnhpercent = document.getElementById("<%= hdnTempvalue.ClientID %>").value;

            document.getElementById("<%= hdnTempvalue.ClientID %>").value = ReimbursableAmount;
            ToTargetFormat($('#<%= hdnTempvalue.ClientID %>'));
            ptempReimbursableAmount = document.getElementById("<%= hdnTempvalue.ClientID %>").value;

            document.getElementById("<%= hdnTempvalue.ClientID %>").value = NonReimbursableAmount;
            ToTargetFormat($('#<%= hdnTempvalue.ClientID %>'));
            ptempNonReimbursableAmount = document.getElementById("<%= hdnTempvalue.ClientID %>").value;

            
              
              FeeViewStateValue += "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^" + PerphyID  + "~Quantity^" + Quantity + "~Amount^"
              + pTempamt + "~Total^" + ptempTotal + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName + "~DisorEnhpercent^" + pTempDisorEnhpercent + "~DisorEnhType^" + DisorEnhType +
               "~Remarks^" + Remarks + "~ReimbursableAmount^" + ptempReimbursableAmount + "~NonReimbursableAmount^" + ptempNonReimbursableAmount + "~AMBCODE^" + AMBCODE + "|";
        
            document.getElementById('<%= hdfBillType1.ClientID %>').value = FeeViewStateValue;
            addAmount(Total, IsRI);
            CreatePaymentTablesDaD();
            
            

        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\DisplayAllDataTemp.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert("Item already added"); }
        }

    }


    function CreatePaymentTablesDaD() {

        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML = "";
        var newPaymentTables, startPaymentTag, endPaymentTag;
        var FeeViewStateValue = document.getElementById('<%= hdfBillType1.ClientID %>').value;

        DisableReferDoctor("ReferDoctor2", "N")
        //startPaymentTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' style='display:none;'> FeeType </th><th scope='col' style='display:none;'> FeeID </th> <th scope='col' style='display:none;'> OtherID </th> <th scope='col' align='center' > Description </th> <th scope='col' align='right'> Perphyname </th> <th scope='col' align='right'>  Quantity </th><th scope='col' align='right'> Amount </th><th scope='col' align='right'>Total</th><th scope='col' align='center'>Date</th><th scope='col' align='center' > Is Reimbursable </th><th scope='col' style='display:none;'> DisorEnhpercent </th><th scope='col' style='display:none;'> DisorEnhType </th><th scope='col' style='display:none;'> Remarks </th><th scope='col' style='display:none;'> ReimbursableAmount </th><th scope='col' style='display:none;'> NonReimbursableAmount </th><th scope='col' align='center'>Delete</th></tr>";
        startPaymentTag ="<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' style='display:none;'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_FeeType%>" + "</th><th scope='col' style='display:none;'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_FeeID %>" +"</th> <th scope='col' style='display:none;'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_OtherID %>" + " </th> <th scope='col' align='center' > " + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_Description %>" + " </th> <th scope='col' align='right'> "+"<%=Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_Perphyname%>" +" </th> <th scope='col' align='right'> " + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_Quantity %>" + " </th><th scope='col' align='right'>  " + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_Amount %>" + " </th><th scope='col' align='right'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_Total %>" + "</th><th scope='col' align='center'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_Date %>" + "</th><th scope='col' align='center' > " + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_IsReimbursable %>" + " </th><th scope='col' style='display:none;'> " + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_DisorEnhpercent %>" + " </th><th scope='col' style='display:none;'> " + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_DisorEnhType %>" + "  </th><th scope='col' style='display:none;'>" +"<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_Remarks %>" + "</th><th scope='col' style='display:none;'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_ReimbursableAmount %>" + " </th><th scope='col' style='display:none;'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_NonReimbursableAmount %>" + "</th><th scope='col' style='display:none;'>" + "<%= Resources.ClientSideDisplayTexts.CommonControls_DisplayAllDataTemp_AMBCODE %>" + " </th><th scope='col' align='center'>" + "<%= Resources.ClientSideDisplayTexts.Common_Delete %>" + "</th></tr>";
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
                        if (arrayChildData[0] == "ReimbursableAmount") {
                            ReimbursableAmount = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "NonReimbursableAmount") {
                            NonReimbursableAmount = arrayChildData[1];
                        }
                        
                        //---Start----
                         if (arrayChildData[0] == "AMBCODE") {
                            AMBCODE = arrayChildData[1];
                        }
                        //---End-----
                        

                    }
                }
                var chkBoxName = "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname +"~PerphyID^" +PerphyID + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + +"~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName + "";
                
                newPaymentTables += "<TR><TD style='display:none;'>" + FeeType + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + FeeID + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + OtherID + "</TD>";
                newPaymentTables += "<TD style='padding-left:10px' align='left'>" + Descrip + "</TD>"
                newPaymentTables += "<TD style='padding-left:5px' align='left'>" + Perphyname + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + PerphyID + "</TD>";
                newPaymentTables += "<TD align='right'>" + Quantity + "</TD>";
                


                newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
                newPaymentTables += "<TD  align='right'>" + Total + "</TD>";
                newPaymentTables += "<TD  align='center'>" + DTime + "</TD>";
                newPaymentTables += "<TD  align='center'>" + IsRI + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + DisorEnhpercent + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + DisorEnhType + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + Remarks + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + ReimbursableAmount + "</TD>";
                newPaymentTables += "<TD style='display:none;'>" + NonReimbursableAmount + "</TD>";
                
                newPaymentTables += "<TD style='display:none;'>" + AMBCODE + "</TD>";
                
                //newPaymentTables += "<TD align='center'><input name='RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^" + PerphyID + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName + "~DisorEnhpercent^" + DisorEnhpercent + "~DisorEnhType^" + DisorEnhType + "~Remarks^" + Remarks + "~ReimbursableAmount^" + ReimbursableAmount + "~NonReimbursableAmount^" + NonReimbursableAmount + "' onclick='btnPaymentDelete_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
                newPaymentTables += "<TD align='center'><input name='RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^" + PerphyID + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName + "~DisorEnhpercent^" + DisorEnhpercent + "~DisorEnhType^" + DisorEnhType + "~Remarks^" + Remarks + "~ReimbursableAmount^" + ReimbursableAmount + "~NonReimbursableAmount^" + NonReimbursableAmount + "~AMBCODE^"+AMBCODE+"' onclick='btnPaymentDelete_OnClick1(name);' value = '<%= Resources.ClientSideDisplayTexts.Common_Delete %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
                DisableReferDoctor("ReferDoctor2", "Y");
               
            }
        }

        newPaymentTables += endPaymentTag;
        document.getElementById('<%= dvPaymentTable.ClientID %>').innerHTML += newPaymentTables;
        if (iChild > 0) {
            fn_DisableClientCntorl(true);
        }
        else {
            fn_DisableClientCntorl(false);
        }

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

                    var tempFeeID, tempFeeType, tempOtherID, iChild, tempFeeDate, tempNRI,tempAMBCode;
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
                            
                             //---Start----
                                 if (arrayChildData[0] == "AMBCODE") {
                                      tempAMBCode = arrayChildData[1];
                                 }
                                 //---End-----
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
            arramt = FeeGotValue[9];
            amtreceived = arramt.split('^')[1];
            deleteAmount(amtreceived, FeeGotValue[11].split('^')[1]);
        }
    
        document.getElementById('<%= hdfBillType1.ClientID %>').value = PaymenttempDatas;
        
        if(tempAMBCode!='')
        {
                  
                Delete_AMBULANCEDETAILS(tempAMBCode);
         }
       
              
        ClearPaymentControlEvents1();
        CreatePaymentTablesDaD();
        AddAmountinTextbox();
        
        
      
    }



    function btnPaymentDeleteFeeID_OnClick(FeeType, FeeID, OtherID, Descrip,Perphyname,PerphyID, Quantity, Amount, Total, DTime, IsRI) {
        var FeeViewStateValue = "RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Perphyname^" + Perphyname + "~PerphyID^"+ PerphyID + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "~DTime^" + DTime + "~IsReimbursable^" + IsRI + "~refType^" + refType + "~refPhyID^" + refPhyID + "~refPhyName^" + refPhyName;
        btnPaymentDelete_OnClick1(FeeViewStateValue);

    }


    function addAmount(addedAmount, nriFlag) {

        var sVal =ToInternalFormat($("#<%= lblTotalAmt.ClientID %>"));
        
        
        sVal = format_number(Number(addedAmount) + Number(sVal), 2);
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = sVal;
        ToTargetFormat($("#<%= lblTotalAmt.ClientID %>"));
        if (nriFlag == "No") {
            var nriVal =ToInternalFormat($("#<%= lblNonReimburseAmt.ClientID %>"));
            nriVal = format_number(Number(addedAmount) + Number(nriVal), 2);
            document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = nriVal;
            ToTargetFormat($("#<%= lblNonReimburseAmt.ClientID %>"));
        }
    }

    function deleteAmount(deletedAmount, nriFlag) {
        var sVal = ToInternalFormat($("#<%= lblTotalAmt.ClientID %>"));
        sVal = format_number(Number(sVal) - Number(deletedAmount), 2);
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = sVal;
        ToTargetFormat($("#<%= lblTotalAmt.ClientID %>"));
        if (nriFlag == "No") {
            var nriVal = ToInternalFormat($("#<%= lblNonReimburseAmt.ClientID %>"));
            nriVal = format_number(Number(nriVal) - Number(deletedAmount), 2);
            document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = nriVal;
            ToTargetFormat($("#<%= lblNonReimburseAmt.ClientID %>"));
        }
    }
    function ClearDisplayData() {
        document.getElementById("<%= lblTotalAmt.ClientID %>").innerHTML = "0.00";
        document.getElementById("<%= hdfBillType1.ClientID %>").value = '';
        document.getElementById("<%= lblNonReimburseAmt.ClientID %>").innerHTML = "0.00";
        ToTargetFormat($("#<%= lblTotalAmt.ClientID %>"));
        ToTargetFormat($("#<%= lblNonReimburseAmt.ClientID %>"));
    }

    function ClearPaymentControlEvents1() {
        document.getElementById('PaymentType_hdfPaymentType').value = "";
        PaymentControlclear1();
        CreatePaymentTables();
        SetReceivedOtherCurr(0, 0, 'OtherCurrencyDisplay1');
    }
    function PaymentControlclear1() {
        document.getElementById('PaymentType_txtAmount').value = document.getElementById('PaymentType_hdfDefaultPaymentMode').value;
        document.getElementById('PaymentType_txtAmount').value = "";
        document.getElementById('PaymentType_txtNumber').value = "";
        document.getElementById('PaymentType_txtBankType').value = "";
        document.getElementById('PaymentType_txtRemarks').value = "";
        document.getElementById('PaymentType_txtServiceCharge').value = "0";
        document.getElementById('PaymentType_txtTotalAmount').innerHTML = "";
        document.getElementById('txtAmountRecieved').value = "0.00";
        ToTargetFormat($("#txtAmountRecieved"));
    }
    function GetDspData() {
        var GetDspDataDetails = "";
        var AmountDetails = document.getElementById('<%= hdfBillType1.ClientID %>').value;
        var TAmountdspData = document.getElementById('<%= lblTotalAmt.ClientID %>').innerText;
        GetDspDataDetails = AmountDetails;
        return GetDspDataDetails;
    }
    
</script>

<asp:HiddenField ID="hdfBillType1" runat="server" />
<asp:HiddenField ID="hdnAmbCode" Value="" runat="server" /> 
<%--<asp:HiddenField ID="hdnPaymentExists" runat="server" />--%>
<asp:HiddenField ID="hdnPaymentsDeleted" runat="server" />
