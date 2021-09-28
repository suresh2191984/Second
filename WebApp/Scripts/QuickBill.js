function GetRefPhysicianDetails(pType) {
    var refType = "";
    var refID = 0
    var refName = "";
    var tRes = refType + "~" + refID + "~" + refName;
    var pVal = document.getElementById(pType + "_hdnPhysicianValue").value.split("~");

    if (pVal.length == 3) {
        refType = pVal[0];
        refID = pVal[1];
        refName = pVal[2];
        tRes = refType + "~" + refID + "~" + refName;
    }
    return tRes;
}
function DisableReferDoctor(pType,pValue) {
    if (pValue == "Y") {
        document.getElementById(pType + "_qrefphy").disabled = true;
    }
    else {
        document.getElementById(pType + "_qrefphy").disabled = false;
    }
}

function setReferringDetails(pType, RefphyId, ReferralType) {
    if (ReferralType == "I") {
        var ddl = document.getElementById(pType + "_ddlPhysician");
        var phName = '';
        document.getElementById(pType + "_rdoInternal").checked = true;
        showInternalRefPhy(pType + "_rdoInternal");
        ddl.value = RefphyId;
        if (ddl.selectedIndex > -1) {
            document.getElementById(pType + "_txtNew").value = ddl.options[ddl.selectedIndex].text;
            phName = ddl.options[ddl.selectedIndex].text;
        }
        document.getElementById(pType + "_hdnPhysicianValue").value = ReferralType + '~' + RefphyId + '~' + phName ;
       
    }
    else if (ReferralType == "E") {
    var ddl = document.getElementById(pType + "_ddlRefPhysician");
    var phName = '';
        document.getElementById(pType + "_rdoExternal").checked = true;
        showExternalRefPhy(pType + "_rdoExternal");
        ddl.value = RefphyId;
        if (ddl.selectedIndex > -1) {
            document.getElementById(pType + "_txtNew").value = ddl.options[ddl.selectedIndex].text;
            phName = ddl.options[ddl.selectedIndex].text;
        }
        document.getElementById(pType + "_hdnPhysicianValue").value = ReferralType + '~' + RefphyId + '~' + phName;
    }
    else {
        DisableReferDoctor(pType, "N");
    }
}
function setOldReferringdetails() {
    var ReferralType = document.getElementById('hdnRefferedPhyType').value;
    var RefphyId = document.getElementById('hdnRefferedPhyID').value;
    if (RefphyId <= 0) {
        DisableReferDoctor("ReferDoctor1", "N");
    }
    else {
        setReferringDetails("ReferDoctor1", RefphyId, ReferralType);
        DisableReferDoctor("ReferDoctor1", "Y");
    }
}
function clearOldReferringdetails() {
    document.getElementById('hdnRefferedPhyType').value = "";
    document.getElementById('hdnRefferedPhyID').value = 0;
}
function showInternalRefPhy(ID) {
    document.getElementById('dvH').style.display = "none";
    var pID = ID.split("_")[0];
    FilterItemsReset1(pID);
    if (document.getElementById(ID).checked == true) {
        document.getElementById(pID + "_divPhysicianName").style.display = 'block';
        document.getElementById(pID + "_divRefPhysicianName").style.display = 'none';
        document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
        document.getElementById(pID + "_txtNew").value = '';
        document.getElementById(pID + "_rdoExternal").checked = false
        document.getElementById(pID + "_trDDLPanel").style.display = "block";
        document.getElementById(pID + "_hdnReferralType").value = 'I';
    }
    else {
        document.getElementById(pID + "_trDDLPanel").style.display = "none";
        document.getElementById('dvH').style.display = "block";
        document.getElementById('ddlHospital').selectedIndex = 0;
    }

}

function showExternalRefPhy(ID) {

    document.getElementById('dvH').style.display = "block";
    var pID = ID.split("_")[0];
    FilterItemsReset2(pID);
    if (document.getElementById(ID).checked == true) {
        document.getElementById(pID + "_divPhysicianName").style.display = 'none';
        document.getElementById(pID + "_divRefPhysicianName").style.display = 'block';
        document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
        document.getElementById(pID + "_txtNew").value = '';
        document.getElementById(pID + "_rdoInternal").checked = false;
        document.getElementById(pID + "_trDDLPanel").style.display = "block";
        document.getElementById(pID + "_hdnReferralType").value = 'E';
    }
    else {
        document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
        document.getElementById(pID + "_trDDLPanel").style.display = "none";
    }
}

function resetRefPhyDetails(ID) {
    document.getElementById(ID + "_trDDLPanel").style.display = 'none';
    document.getElementById(ID + "_rdoInternal").checked = false;
    document.getElementById(ID + "_rdoExternal").checked = false
    document.getElementById('dvH').style.display = 'none';
} 

function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

    var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(2) / parseFloat(pCurrAmount).toFixed(2)).toFixed(2);
    document.getElementById(ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;
    
    document.getElementById(ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
    document.getElementById(ConValue + "_lblOtherCurrPaybleAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrPayble").value = parseFloat(pTotalNetAmt).toFixed(2);
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrPaybleAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrPayble"));

}
function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge,ConValue) {
    var pTotalNetAmt = Number(pNetAmount);
    document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrReceived").value = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = parseFloat(pServiceCharge).toFixed(2);
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrRecdAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrReceived"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"));


}
function isOtherCurrDisplay(pType) {
    if (pType == "B") {
//        document.getElementById("OtherCurrencyDisplay1_tbOtherCurr").style.display = "block";
    }
}
function isOtherCurrDisplay1(pType) {
    if (pType == "B") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "block";
    }
    if (pType == "N") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
    }


}
function getOtherCurrAmtValues(pType, ConValue) {
    if (pType == "REC") {
        
        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrReceived")) == "" ? "0" : parseFloat(ToInternalFormat($("#" + ConValue + "_hdnOterCurrReceived"))).toFixed(2);
        return pAMt;
    }
    if (pType == "PAY") {
        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrPayble")) == "" ? "0" : parseFloat(ToInternalFormat($("#" + ConValue + "_hdnOterCurrPayble"))).toFixed(2);
        return parseFloat(pAMt).toFixed(2);
    }
    if (pType == "SER") {
        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrServiceCharge")) == "" ? "0" : parseFloat(ToInternalFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"))).toFixed(2);
        return parseFloat(pAMt).toFixed(2);
    }
}
function ClearOtherCurrValues(ConValue) {
    document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = 0;
    document.getElementById(ConValue + "_hdnOterCurrReceived").value = 0;
    document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = 0;
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrRecdAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrReceived"));

}

function Calc_Copayment() {  
     
     if(document.getElementById('QPR_rdoOP').checked==true && getCreditBill()==true
     && document.getElementById('btnSave').style.display=="block"){       
        var totalNonMedical= document.getElementById('lblNonMedicalAmt').innerHTML;//ToInternalFormat("$lblNonMedicalAmt");
        var totalMedial=Number(document.getElementById('dspData_lblTotalAmt').innerHTML)- Number(totalNonMedical) ;  //Number(ToInternalFormat('$dspData_lblTotalAmt'))- Number(totalNonMedical) ; 
        var CoPaymentlogic=getPaymentlogicID();
        var Copayment_Percentage=Number(getCoPaymentperent()).toFixed(2);
        var PrAutAmount=Number(getPreAuthamount()).toFixed(2);       
        var Claimlogin=getClaimID();
        var _claimAmount=0;       
        if(Number(PrAutAmount)>0 ||  Number(Copayment_Percentage)>0){  
         document.getElementById('tdCopayment').style.display="block";  
        _actualCoPayment=Copayment_Login(CoPaymentlogic,Copayment_Percentage,PrAutAmount,totalMedial);                  
        _claimAmount=Copayment_Deducted_Login(Claimlogin,PrAutAmount,totalMedial,_actualCoPayment);                  
         var NetValue= ToInternalFormat($('#txtGrandTotal'));    
         document.getElementById("lblDifferenceAmount").innerHTML= (Number(NetValue)- Number(_claimAmount)).toFixed(2);    
         
         document.getElementById('lblActualCopaymenttxt').innerHTML = _actualCoPayment.toFixed(2);                   
         document.getElementById("lblClaminAmount").innerHTML=Number(_claimAmount).toFixed(2);
             
         document.getElementById('hdnTotalCopayment').value=_actualCoPayment.toFixed(2);         
         document.getElementById('hdnClaim').value=Number(_claimAmount).toFixed(2);    
         document.getElementById('hdnTowardsAmount').value=(Number(NetValue)- Number(_claimAmount)).toFixed(2);         
         
         document.getElementById("lblMedical").innerHTML=totalMedial;
         document.getElementById("lblNonMedical").innerHTML=totalNonMedical;
                  
         ToTargetFormat($('#lblActualCopaymenttxt'));
         ToTargetFormat($('#lblClaminAmount'));   
         ToTargetFormat($('#lblDifferenceAmount'));  
        
        }    
       }  
       else
       {
        document.getElementById('tdCopayment').style.display="none";
       }  
     }
     
     
     function Copayment_Login(CoPaymentlogic,Copayment_Percentage,PrAutAmount,totalMedial)
     {
        var _actualCoPayment=0;
        if (Number(Copayment_Percentage) > 0) {
               if (CoPaymentlogic == 0) {
                   if (Number(PrAutAmount) < Number(totalMedial)) {
                       _actualCoPayment=(Number(PrAutAmount) * Number(Copayment_Percentage)) / 100;
                   }
                   else {
                       _actualCoPayment=(Number(totalMedial) * Number(Copayment_Percentage)) / 100;
                   }
               }
               else if (CoPaymentlogic == 1) {
                   _actualCoPayment=(Number(totalMedial) * Number(Copayment_Percentage)) / 100;
               }
               else if (CoPaymentlogic == 2) {
                   _actualCoPayment=(Number(PrAutAmount) * Number(Copayment_Percentage)) / 100;
               }
           }
           else {
               _actualCoPayment= 0;
           }
           
         return _actualCoPayment;
     }
     
     function Copayment_Deducted_Login(Claimlogin,PrAutAmount,totalMedical,_actualCoPayment)
     {       
            var _claimAmount=0;
            if (Number(Claimlogin) == 1) {
                _claimAmount = Number(totalMedical) - Number(_actualCoPayment);
            }
            else if(Number(Claimlogin) == 2)  {
                 _claimAmount = Number(PrAutAmount) - Number(_actualCoPayment);
            }
            return _claimAmount;                
     }
     

    

